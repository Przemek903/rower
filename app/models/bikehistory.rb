class Bikehistory < ActiveRecord::Base




	def self.count_avaliability(stationName, period)
		bikeHist = self.where(name: stationName)
		result = {}

		if period == "day"
			result = self.count_day_avaliability(bikeHist)
		elsif period == "month"
			result = self.count_month_avaliability(bikeHist)
		else
			result = self.count_hour_avaliability(bikeHist)
		end
	end

private
	def self.count_hour_avaliability(bikeHist)
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
		result
	end

	def self.count_day_avaliability(bikeHist)
		result = {}
		(1..31).each do |day|
			temp = 0.0
			tempResult = 0.0
			bikeHist.each do |hist|
				if hist.created_at.day == day
					if hist.bikes == "5+"
						tempResult = tempResult + 5.0
						temp = temp + 1.0
					else
						tempResult = tempResult + hist.bikes.to_i
						temp = temp + 1.0
					end
				end
			end
			result[day] = tempResult/temp
		end
		result
	end

	def self.count_month_avaliability(bikeHist)
		result = {}
		(1..12).each do |month|
			temp = 0.0
			tempResult = 0.0
			bikeHist.each do |hist|
				if hist.created_at.month == month
					if hist.bikes == "5+"
						tempResult = tempResult + 5.0
						temp = temp + 1.0
					else
						tempResult = tempResult + hist.bikes.to_i
						temp = temp + 1.0
					end
				end
			end
			result[month] = tempResult/temp
		end
		result
	end
end
