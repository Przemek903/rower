desc "Count number of hire"
task :hire_number => :environment do
	HireWeek.delete_all
	week = ['monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday', 'sunday']
	week.each do |day|
		HireWeek.create(
			name: 		day,
			count: 0
			)
	end
	monday = 0
	tuesday = 0
	wednesday = 0
	thursday = 0
	friday = 0
	saturday = 0
	sunday = 0
	stations = Station.all
	stations.each do |stat|
		bikehistories = Bikehistory.where(name: stat.name)
		actualBikeNumbers = bikehistories.first.bike_numbers
		bikehistories.each do |hist|
			if actualBikeNumbers != hist.bike_numbers
				createDay = hist.created_at.wday
				case createDay
				when 1
					monday =  monday + 1
				when 2
					tuesday = tuesday + 1
				when 3
					wednesday = wednesday + 1
				when 4
					thursday = thursday + 1
				when 5
					friday = friday + 1
				when 6
					saturday = saturday + 1
				when 0
					sunday = sunday + 1
				end
				actualBikeNumbers = hist.bike_numbers
			end
		end
	end
	weekHash = {
		'monday' => monday,
		'tuesday' => tuesday,
		'wednesday' => wednesday,
		'thursday' => thursday,
		'friday' => friday,
		'saturday' => saturday,
		'sunday' => sunday
	}
	week.each do |day|
		HireWeek.where(name: day).first.update_attributes(
			count: weekHash[day]
			)
	end
end

#done