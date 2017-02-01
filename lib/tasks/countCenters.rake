desc "Find centers of clusters"
task :find_centers => :environment do
  numberOfClusters = 50
  (1..numberOfClusters).each do |clusterNumber|
    sumOfLat, sumOfLng = 0.0, 0.0
    numberOfStations = 0
    Station.where(clusterKMean_id: clusterNumber).each do  |station|
      sumOfLat = sumOfLat + station.lat
      sumOfLng = sumOfLng + station.lng
      numberOfStations = numberOfStations + 1
    end
    ClusterKMean.find(clusterNumber).update_attributes(lat: (sumOfLat/numberOfStations), lng: (sumOfLng/numberOfStations))
  end
end