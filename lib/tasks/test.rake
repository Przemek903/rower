desc "Testing"
task :test_data => :environment do

	allki = Bikehistory.all.count
	p 'Liczba wierszy w tablicy ' + allki.to_s

	uniqBk = Bikehistory.all(
		:select => 'DISTINCT ON (bikehistories.bike_numbers) *',
		:order => 'bikehistories.bike_numbers'
		)

	p 'Liczba unikalnych wierszy w tablicy ' + uniqBk.length.to_s

	uniqSort = uniqBk.sort_by {|el| el[:created_at]}

	fileWrite = File.open('hej.txt', 'w')

	months = [11]
	days = (2..30).to_a
	hours = (1..20).to_a
	months.each do |month|
		średniah = 0
		days.each do |day|
			hours.each do |hour|
				lastHourBikes = []
				oneHourback = Time.new(2015,month,day,(hour+3),0,30)
				toHour = Time.new(2015,month,day,hour,0,0)
				# p oneHourback
				# p toHour

				uniqSort.each do |e|
					if e[:created_at] <= oneHourback and e[:created_at] >= toHour
						lastHourBikes << e
					end
				end

				# p lastHourBikes.count

				# lastHourBikes = uniqSort.first(1688)

				# p lastHourBikes.first(1)
				# p lastHourBikes.last(1)
				bikeNumbers = (60000..70000).to_a

				count1h = 0


				bikeNumbers.each do |bike|
					a = []
					lastHourBikes.each do |el|
						if !(el[:bike_numbers].nil?) and el[:bike_numbers].include? bike.to_s
							a << el
						end
					end
					if a.length > 1
						b = a.uniq {|e| e[:stationId] }

						if b.length > 1
							count1h  = count1h + (b.length - 1)
							# p b.length
							# p "                           "
							# p "                           "
							# p "                           "
							# p b
						end
					end
				end

				if lastHourBikes.count > 0
					fileWrite.write( (hour).to_s + "," + (hour+3).to_s + "," +  count1h.to_s + " \n")
				end
			end
		end
	end
	fileWrite.close

	# p 'Liczba unikalnych wierszy w ostatnich 3 godzinach ' + lastHourBikes.length.to_s

	# count = 0

	# bikeNumbers.each do |bike|
	# 	a = []
	# 	uniqSort.each do |el|
	# 		if !(el[:bike_numbers].nil?) and el[:bike_numbers].include? bike.to_s
	# 			a << el
	# 		end
	# 	end
	# 	if a.length > 1
	# 		b = a.uniq {|e| e[:stationId] }

	# 		if b.length > 1
	# 			count  = count + (b.length - 1)
	# 			# p b.length
	# 			# p "                           "
	# 			# p "                           "
	# 			# p "                           "
	# 			# p b
	# 		end
	# 	end

	# end
	# p 'Liczba wykrytch zmian rowerow na stacjach ' + count.to_s

	# count1h = 0


	# bikeNumbers.each do |bike|
	# 	a = []
	# 	lastHourBikes.each do |el|
	# 		if !(el[:bike_numbers].nil?) and el[:bike_numbers].include? bike.to_s
	# 			a << el
	# 		end
	# 	end
	# 	if a.length > 1
	# 		b = a.uniq {|e| e[:stationId] }

	# 		if b.length > 1
	# 			count1h  = count1h + (b.length - 1)
	# 			# p b.length
	# 			# p "                           "
	# 			# p "                           "
	# 			# p "                           "
	# 			# p b
	# 		end
	# 	end
	# end
	# p 'Liczba wykrytch zmian rowerow w ostatnich 3 godzinach ' + count1h.to_s


end