require 'kmeans-clusterer'
desc "Create clusters - kmeans method"
task :create_clusters_kmeans => :environment do

	stations = Station.first(284)

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

	p resultClusters
  p resultCentroids

	fillStationsData(resultClusters, resultCentroids)
end


def fillStationsData(resultClusters, resultCentroids)
	Station.update_all(clusterKMean_id: nil)
	resultClusters.each_with_index do |el, ind|
		el.each do |num|
			Station.find(num).update_columns(clusterKMean_id: (ind+1) )
		end
	end
end