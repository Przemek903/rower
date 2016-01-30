desc "Add bikes data to Bike model"
task :add_bikes => :environment do
	bikeHist = Bikehistory.all

	bikeHist.each do |hist|
		if hist.bike_numbers != nil
			numbers = hist.bike_numbers.split(",").map(&:to_i)
			numbers.each do |num|
				unless Bike.where(:number => num).exists?
					Bike.create(
						number: 		num, 		# Bike Number
						count: 			0 			# Count
					)
				end

			end
		end
	end
end