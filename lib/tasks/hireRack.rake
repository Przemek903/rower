desc "HireToRackNumber"
task :hire_to_rackNumber => :environment do
  Station.update_all(rack: nil, hireRack:nil)
  stations = Station.all

  stations.each do |station|
    p station.id
    actualBikeHistory = Bikehistory.where(stationId: station.stationNumber).last
    station.update_attributes(rack: actualBikeHistory.bike_racks, hireRack: station.hireCount/actualBikeHistory.bike_racks)
  end
end

