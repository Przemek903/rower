class AnalysisController < ApplicationController

  def availability
  	@result = Bikehistory.count_avaliability(params[:stationName], params[:period])
  end

  def agglomerative
  	@agglomerative = Station.count_convex_agglomerative
  end

  def kmeans
  	@kmeans = Station.count_convex_kmean
  end

  def hire
  	@hireNumber = Bikehistory.count_hire_number(params[:stationName])
  	@station = Station.where(name: params[:stationName])
  	@lessHire = Station.order(:hireCount).limit(3)
  	@topHire = Station.order(:hireCount).reverse_order.limit(3)
  end

  def hirefrequency
    @hireHash = HireWeek.recordToHash
  end


# private
# 	def count_convex
# 		convex_points = []
# 		(1..50).each do |num|
# 			stations = Station.where(clusterAgglomerative_id: num )
# 			points = []

# 			stations.each do |st|
# 				points.push([st.lat , st.lng])
# 			end
# 			a =  convex_hull(points)
# 			convex_points.push(a)
# 		end

# 		p convex_points
# 	end

# 	def convex_hull(points)
# 	  points.sort!.uniq!
# 	  return points if points.length <= 3
# 	  def cross(o, a, b)
# 	    (a[0] - o[0]) * (b[1] - o[1]) - (a[1] - o[1]) * (b[0] - o[0])
# 	  end
# 	  lower = Array.new
# 	  points.each{|p|
# 	    while lower.length > 1 and cross(lower[-2], lower[-1], p) <= 0 do lower.pop end
# 	    lower.push(p)
# 	  }
# 	  upper = Array.new
# 	  points.reverse_each{|p|
# 	    while upper.length > 1 and cross(upper[-2], upper[-1], p) <= 0 do upper.pop end
# 	    upper.push(p)
# 	  }
# 	  return lower[0...-1] + upper[0...-1]
# 	end

end
