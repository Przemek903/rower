desc "AddToDatabase"
task :add_data => :environment do
	require 'date'

	lines = File.new('main_smaller.csv').readlines
  	lines.each do |line|
    	values = line.strip.split(';')
    	Bikehistory.create(
			stationId: 		values[1].to_i, 		# Station ID
			laf: 			values[2].to_f, 		# Latitude
			lng:  			values[3].to_f,		# Longitude
			name: 			values[4],			# Station name
			bikes: 			values[5],			# Number of bikes
			bike_racks: 	values[6].to_i,	# Number of racks
			bike_numbers: 	values[7],	# Bike's numbers in station
			city_id: 		1,							# City ID
			created_at: 	DateTime.new(values[9][0..3].to_i, values[9][5..6].to_i, values[9][8..9].to_i, values[9][11..12].to_i, values[9][14..15].to_i, values[9][17..18].to_i),
			updated_at: 	DateTime.new(values[9][0..3].to_i, values[9][5..6].to_i, values[9][8..9].to_i, values[9][11..12].to_i, values[9][14..15].to_i, values[9][17..18].to_i)
		)
  	end
end

#done