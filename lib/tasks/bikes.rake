desc "CollectBikeNumbers"
task :bikes_data => :environment do
	allki = Bikehistory.all.count

	uniqBk = Bikehistory.all(
		:select => 'DISTINCT ON (bikehistories.bike_numbers) *',
		:order => 'bikehistories.bike_numbers'
		)
	fileWrite = File.open('nrRowerow.txt', 'w')
	bikeNumbers = (60000..70000).to_a
	rowery = []

	bikeNumbers.each do |bike|
		uniqBk.each do |uni|
			if !(uni[:bike_numbers].nil?) and uni[:bike_numbers].include? bike.to_s
				rowery << bike
				fileWrite.write(bike.to_s + ",")
				break
			end
		end
	end
	p rowery.count
end