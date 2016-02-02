desc "Count all availability"
task :count_avi => :environment do
	bikeHist = Bikehistory.where(name: "al. Jana Pawła II - ul. Stawki")
	result = {}

	(0..23).each do |hour|
		temp = 0.0
		tempResult = 0.0
		bikeHist.each do |hist|
			if hist.created_at.hour == hour
				if hist.bikes == "5+"
					tempResult = tempResult + 5.0
					temp = temp + 1.0
				else
					tempResult = tempResult + hist.bikes.to_i
					temp = temp + 1.0
				end
			end
		end
		result[hour] = tempResult/temp
	end

	p result
end