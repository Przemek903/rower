class Station < ActiveRecord::Base



	def self.count_convex_agglomerative
		convex_points = []
		(1..50).each do |num|
			stations = Station.where(clusterAgglomerative_id: num )
			points = []

			stations.each do |st|
				points.push([st.lat , st.lng])
			end
			a =  self.convex_hull(points)
			convex_points.push(a)
		end
		convex_hash = convert_convex_array_to_hash(convex_points)
		return convex_hash
	end

	def self.count_convex_kmean
		convex_points = []
		(1..50).each do |num|
			stations = Station.where(clusterKMean_id: num )
			points = []

			stations.each do |st|
				points.push([st.lat , st.lng])
			end
			a =  self.convex_hull(points)
			convex_points.push(a)
		end
		convex_hash = convert_convex_array_to_hash(convex_points)
		return convex_hash
	end

private

	def self.convex_hull(points)
	  points.sort!.uniq!
	  return points if points.length <= 3
	  def self.cross(o, a, b)
	    (a[0] - o[0]) * (b[1] - o[1]) - (a[1] - o[1]) * (b[0] - o[0])
	  end
	  lower = Array.new
	  points.each{|p|
	    while lower.length > 1 and self.cross(lower[-2], lower[-1], p) <= 0 do lower.pop end
	    lower.push(p)
	  }
	  upper = Array.new
	  points.reverse_each{|p|
	    while upper.length > 1 and self.cross(upper[-2], upper[-1], p) <= 0 do upper.pop end
	    upper.push(p)
	  }
	  return lower[0...-1] + upper[0...-1]
	end

	def self.convert_convex_array_to_hash(convex_points)
		convertedArray = []
		convex_points.each do |tab|
			tempArr = []
			tab.each do |el|
				tempArr.push({lat:  el[0], lng: el[1]})
			end
			convertedArray.push(tempArr)
		end
		return convertedArray
	end
end
