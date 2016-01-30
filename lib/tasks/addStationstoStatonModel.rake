desc "Add stations data to Station model"
task :add_stations => :environment do
	bikeHist = Bikehistory.all

	bikeHist.each do |hist|
		stationName = hist.name
			unless Station.where(:name => stationName).exists?
				Station.create(
					stationNumber: 		hist["stationId"], 	# Station Number
					lat: 				hist["laf"], 		# Latitude
					lng:  				hist["lng"],		# Longitude
					name: 				hist["name"]		# Station name
				)
			end
	end
end