desc "Create clusters - agglomerative method"
task :create_clusters_aggl => :environment do
	stations = Station.first(284)
	p stations.count
	reshapeDistanceArray = createDistanceArray(stations)

	shortHash = {}
	(0..stations.length-1).each do |k|
		shortHash[k] = "#{k}"
	end

	$foo = []

	minIndexes =  findMinPositionInArray(reshapeDistanceArray)
	minimum = reshapeDistanceArray[minIndexes[0]][minIndexes[1]]
	minIndexes.sort
	distanceHash = createDistanceHash(stations)

	changedArray, changedHash, shortHash = mergeClusters(distanceHash, minIndexes, reshapeDistanceArray, shortHash, minimum)

	(1.. stations.length-3).each do |c|
		minIndexes =  findMinPositionInArray(changedArray)
		minimum = reshapeDistanceArray[minIndexes[0]][minIndexes[1]]
		minIndexes.sort

		changedArray, changedHash, shortHash = mergeClusters(changedHash, minIndexes, changedArray, shortHash, minimum)

	end

	addDataToCluster($foo)

end



def calcDistance(firstPoint, secondPoint)
	r = 6378.41;
	dLat = (firstPoint.lat - secondPoint.lat) * Math::PI / 180
	dLng = (firstPoint.lng - secondPoint.lng) * Math::PI / 180
	lat1 = firstPoint.lat * Math::PI / 180
	lat2 = secondPoint.lat * Math::PI / 180

	a = Math.sin(dLat/2) * Math.sin(dLat/2) + Math.sin(dLng/2) * Math.sin(dLng/2) * Math.cos(lat1) * Math.cos(lat2)
	c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a))
	d = r * c
	d
end

def createDistanceArray(stations)
	distanceArray = []
	stations.each do |firstStation|
		stations.each do |secondStation|
			distanceArray.push(calcDistance(firstStation, secondStation))
		end
	end
	reshapeDistanceArray = distanceArray.each_slice(stations.length).to_a
end

def createDistanceHash(stations)
	distanceHash = {}
	temp = 0
	stations.each do |firstStation|
		tempArray = []
		stations.each do |secondStation|
			tempArray.push(calcDistance(firstStation, secondStation))
		end
		distanceHash[temp] = {"#{temp}" => tempArray}
		temp = temp + 1
	end
	distanceHash
end

def findMinPositionInArray(reshapeDistanceArray)
	tempi = 0
	tempj = 0
	minimum = 1000000000.0
	(0..(reshapeDistanceArray.length - 1)).each do |i|
		(0..(reshapeDistanceArray.length - 1)).each do |j|
			if reshapeDistanceArray[i][j] != 0.0 and reshapeDistanceArray[i][j] < minimum
				minimum = reshapeDistanceArray[i][j]
				tempi = i
				tempj = j
			end
		end
	end
	return tempi, tempj
end

def mergeClusters(distanceHash, minIndexes, reshapeDistanceArray, shortHash, minimum)

	firstCluster = distanceHash[minIndexes[0]]
	firstkey = firstCluster.to_a[0][0]
	firstValue = firstCluster.to_a[0][1]

	secondCluster = distanceHash[minIndexes[1]]
	secondkey = secondCluster.to_a[0][0]
	secondValue = secondCluster.to_a[0][1]

	lengthOfArray = secondValue.length

	tab = []

	(0..lengthOfArray-1).each do |ind|
		firstValue[ind] <= secondValue[ind]  ? tab[ind] = firstValue[ind] : tab[ind] = secondValue[ind]
	end

	reshapeDistanceArray[minIndexes[0]] = tab
	reshapeDistanceArray.delete_at(minIndexes[1])

	reshapeDistanceArray.each do |row|
		row.delete_at(minIndexes[1])
	end

	changedArray =  changeUnderandUpperDiagonal(reshapeDistanceArray)

	changedHash = {}

	(0..(changedArray.length-1)).each do |i|
		if i == minIndexes[0] #or i == minIndexes[1]
			changedHash[minIndexes[0]] = {"#{firstkey},#{secondkey}" => changedArray[minIndexes[0]]}
		else
			if  minIndexes[0]== 0 and minIndexes[1] == 1
				changedHash[i] = { "#{i+1}" => changedArray[i]}
			elsif  (minIndexes[0] == (lengthOfArray - 2)) and  (minIndexes[1] == (lengthOfArray - 1))
				changedHash[i] = { "#{i}" => changedArray[i]}
			elsif (minIndexes[0] + 1 == minIndexes[1]) or (minIndexes[1] + 1 == minIndexes[0])
				if (i< minIndexes[0])
					changedHash[i] = { "#{i}" => changedArray[i]}
				else
					changedHash[i] = { "#{i+1}" => changedArray[i]}
				end
			else
				if (i < minIndexes[0])
					changedHash[i] = { "#{i}" => changedArray[i]}
				elsif (i > minIndexes[0]) and (i < minIndexes[1])
					changedHash[i] = { "#{i}" => changedArray[i]}
				elsif (i >= minIndexes[1])
					changedHash[i] = { "#{i+1}" => changedArray[i]}
				end
			end
		end
	end


	resultHash = {}

	changedHash.each do |k,v|
		resultHash[k] = v.keys[0]
	end


	finalHash = {}

	resultHash.each do |k,v|
		if k != minIndexes[0]
			finalHash[k] = shortHash[v.to_i]
		else
			finalHash[k] = v
		end
	end

	# p "final hash"
	# p finalHash

	# p "----------------------------------------"

	completeHash = {}
	changedHash.each do |k,v|
		completeHash[k] = { finalHash.values.to_a[k] => v.values[0] }
	end

	$foo.push([minimum, finalHash])


	return changedArray, completeHash, finalHash
end

def changeUnderandUpperDiagonal(reshapeDistanceArray)

	tempArray = reshapeDistanceArray
	(0..reshapeDistanceArray.length-1).each do |i|
		(0..reshapeDistanceArray.length-1).each do |j|
			if reshapeDistanceArray[i][j] > reshapeDistanceArray[j][i]
				tempArray[i][j] = reshapeDistanceArray[j][i]
				tempArray[j][i] = reshapeDistanceArray[j][i]
			elsif reshapeDistanceArray[i][j] < reshapeDistanceArray[j][i]
				tempArray[i][j] = reshapeDistanceArray[i][j]
				tempArray[j][i] = reshapeDistanceArray[i][j]
			end
		end
	end
	tempArray
end

def addDataToCluster(clusterResultTable)
	clusterTable = []
	num = 233
	p clusterResultTable[num][1]
	p clusterResultTable[num][0]
	clusterResultTable[num][1].each do |k,v|
		clusterTable.push(v.split(","))
	end
	p clusterTable.length
	fillStationsData(clusterTable)
end

def fillStationsData(clusterTable)
	Station.update_all(clusterAgglomerative_id: nil)
	clusterTable.each_with_index do |el, ind|
		el.each do |num|
			Station.find((num.to_i + 1)).update_columns(clusterAgglomerative_id: (ind+1))
		end
	end
end