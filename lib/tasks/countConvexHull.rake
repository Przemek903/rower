desc "Convex hull"
task :count_convex => :environment do
	stations = Station.where(clusterAgglomerative_id: 1 )
	points = []

	stations.each do |st|
		points.push([st.lat , st.lng])
	end
	a =  convex_hull(points)
	p a
end

def convex_hull(points)
  points.sort!.uniq!
  return points if points.length <= 3
  def cross(o, a, b)
    (a[0] - o[0]) * (b[1] - o[1]) - (a[1] - o[1]) * (b[0] - o[0])
  end
  lower = Array.new
  points.each{|p|
    while lower.length > 1 and cross(lower[-2], lower[-1], p) <= 0 do lower.pop end
    lower.push(p)
  }
  upper = Array.new
  points.reverse_each{|p|
    while upper.length > 1 and cross(upper[-2], upper[-1], p) <= 0 do upper.pop end
    upper.push(p)
  }
  return lower[0...-1] + upper[0...-1]
end