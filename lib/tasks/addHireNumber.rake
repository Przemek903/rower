desc "Add hire number for stations"
task :add_hire_number => :environment do
	stations = Station.all

	stations.each do |station|
		bikehistories = Bikehistory.where(name: station.name)
		count = 0
		actualBikeNumber = bikehistories.first
		bikehistories.each do |bike|
			if actualBikeNumber != bike.bike_numbers
				count = count + 1
			end
			actualBikeNumber = bike.bike_numbers
		end
		station.update_attributes(:hireCount => count)
	end
end