desc "Add hire number for stations"
task :add_hire_number => :environment do
	stations = Station.all
  i = 0
	stations.each do |station|
		bikehistories = Bikehistory.where(name: station.name)
		count = 0
		if bikehistories.present?
      actualBikeNumber = bikehistories.first.bike_numbers
  		bikehistories.each do |bike|
  			if actualBikeNumber != bike.bike_numbers
  				count = count + 1
  			end
  			actualBikeNumber = bike.bike_numbers
  		end
    end
		station.update_attributes(:hireCount => count)
    i = i + 1
    p i
	end
end

#done