class HireWeek < ActiveRecord::Base

	def self.recordToHash
		results = self.all
		hash = {}
		results.each do |res|
			hash[res.name] = res.count
		end
		hash
	end
end
