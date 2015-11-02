desc "Crawl data from nextbike API"
task :crawl_data => :environment do
  	require 'nokogiri'
  	require 'open-uri'

  	url = "https://nextbike.net/maps/nextbike-official.xml"
	xml = Nokogiri::XML(open(url))
	warsaw = xml.xpath('//city[@name="Warszawa"]/place')

	warsaw.each do |station|
		Bikehistory.create(
			stationId: 		station["uid"].to_i, 		# Station ID
			laf: 			station["lat"].to_f, 		# Latitude
			lng:  			station["lng"].to_f,		# Longitude	
			name: 			station["name"],			# Station name
			bikes: 			station["bikes"],			# Number of bikes
			bike_racks: 	station["bike_racks"].to_i,	# Number of racks
			bike_numbers: 	station["bike_numbers"],	# Bike's numbers in station
			city_id: 		1							# City ID
		)  
	end
end
