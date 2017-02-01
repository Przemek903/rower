desc "Find middle of cluster"
task :center_data => :environment do
  ClusterKMean.delete_all
  stations = Station.all

  data = []
  labels = []

  stations.each do |st|
    data.push([st.lat , st.lng])
    labels.push(st.id)
  end

  k = 50

  kmeans = KMeansClusterer.run k, data, labels: labels, runs: 50

  resultClusters = []
  resultCentroids = []

  kmeans.clusters.each do |cluster|
      resultClusters.push(cluster.points.map(&:label))
      resultCentroids.push([cluster.centroid[0], cluster.centroid[1]])
  end

  # temp = ClusterKMean.first.id
  # p temp
  resultCentroids.each_with_index do |centroid, index|
    ClusterKMean.create(
      numberOfStations:    resultClusters[index].count,    # Number of stations
      lat:      centroid[0],    # Latitude
      lng:        centroid[1]    # Longitude
    )
  end

end

#done?