desc "Tescik"
task :hire_time => :environment do
  start = Time.now
  # ClusterTraffic.update_all(count: nil)
  # allki = Bikehistory.all.count
  # p 'Liczba wierszy w tablicy ' + allki.to_s

  # uniqBk = Bikehistory.where("created_at >= ? AND created_at <= ?", Time.new(2016, 7, 1), Time.new(2016, 8, 1) ).all(
  #   :select => 'DISTINCT ON (bikehistories.bike_numbers) *',
  #   :order => 'bikehistories.bike_numbers'
  #   )

  uniqBk = Bikehistory.all(
    :select => 'DISTINCT ON (bikehistories.bike_numbers) *',
    :order => 'bikehistories.bike_numbers'
    )

  # uniqBk = Bikehistory.last(100000)

  uniqSort = uniqBk.sort_by {|el| el[:created_at]}
  p 'Liczba unikalnych wierszy w tablicy ' + uniqBk.length.to_s
  traffic = []
  clusterRange = (1..50).to_a
  clusterStationNubmers = {}
  clusterRange.each do |cl|
    stationNumbers = []
    st = Station.where(clusterKMean_id: cl)
    st.each do |s|
      stationNumbers << s.stationNumber
    end
    clusterStationNubmers[cl] = stationNumbers
  end

  bikeNumbers = []
  Bike.all.each do |b|
    bikeNumbers << b.number
  end


  count = 1
  p "BikeNumbers - #{Bike.all.count}"
  time = 0
  trafficCount = 0
  bikeNumbers.each do |bike|
      bikeCurrentCluster = 1
      bikeMembership = false
      a = []
      uniqSort.each do |el|
        if !(el[:bike_numbers].nil?) and el[:bike_numbers].include? bike.to_s
          clusterStationNubmers.each do |key, csn|
            if bikeMembership == false or (csn.include?(el.stationId) and bikeCurrentCluster != key)
              bikeCurrentCluster = key
              a << el
            end
          end
          bikeMembership = true
        end
      end
      if a.length > 1
        b = a.reverse.uniq {|e| e[:stationId] }.reverse
        if b.length > 1
            temp = nil
            act = nil
            b.each_with_index do |val,index|
              if index == 0
                temp = val
                next
              end
            act = val
            time = time + (act.created_at - temp.created_at)
            temp = act
            trafficCount = trafficCount + 1
        end
        end
      end
    p count
    count = count + 1
  end
  # p traffic
  # # p "----------------------------------------"
  # # p traffic[1]
  # # p traffic[2]
  # # p traffic[3]
  # # p traffic[4]
  # p traffic.size
  # time = 0
  # trafficCount = 0
  # traffic.each do |traf|
  #   temp = nil
  #   act = nil
  #   traf.each_with_index do |val,index|
  #     if index == 0
  #       temp = val
  #       next
  #     end
  #     act = val
  #     time = time + (act.created_at - temp.created_at)
  #     temp = act
  #     trafficCount = trafficCount + 1
  #   end
  # end
  p time
  p trafficCount

  p "Co #{Time.at(time/trafficCount).utc.strftime("%H:%M:%S")}"

  # traffic.each do |traf|
  #   temp = nil
  #   act = nil
  #   traf.each_with_index do |val,index|
  #     if index == 0
  #       act = Station.where(stationNumber: val.stationId).first.clusterKMean_id
  #       next
  #     end
  #     temp = Station.where(stationNumber: val.stationId).first.clusterKMean_id
  #     clusterRecord = ClusterTraffic.find_or_create_by(fromCluster: act, toCluster: temp)
  #     if clusterRecord.count == nil
  #       clusterRecord.update_columns(count: 1 )
  #     else
  #       clusterRecord.update_columns(count: (clusterRecord.count + 1) )
  #     end
  #     p "Z: #{act} ---- Do: #{temp}"
  #     act = temp
  #   end
  # end

  finish = Time.now
  diff = finish - start
  p '-----------------------------------------------------------'
  p diff
  # p "Liczba traffic"
  # p ClusterTraffic.where.not(count:nil).count

  # fileWrite = File.open('hej.txt', 'w')

  # months = [11]
  # days = (2..30).to_a
  # hours = (1..20).to_a
  # months.each do |month|
  #   średniah = 0
  #   days.each do |day|
  #     hours.each do |hour|
  #       lastHourBikes = []
  #       oneHourback = Time.new(2015,month,day,(hour+3),0,30)
  #       toHour = Time.new(2015,month,day,hour,0,0)
  #       # p oneHourback
  #       # p toHour

  #       uniqSort.each do |e|
  #         if e[:created_at] <= oneHourback and e[:created_at] >= toHour
  #           lastHourBikes << e
  #         end
  #       end

  #       # p lastHourBikes.count

  #       # lastHourBikes = uniqSort.first(1688)

  #       # p lastHourBikes.first(1)
  #       # p lastHourBikes.last(1)
  #       bikeNumbers = (60000..70000).to_a

  #       count1h = 0


  #       bikeNumbers.each do |bike|
  #         a = []
  #         lastHourBikes.each do |el|
  #           if !(el[:bike_numbers].nil?) and el[:bike_numbers].include? bike.to_s
  #             a << el
  #           end
  #         end
  #         if a.length > 1
  #           b = a.uniq {|e| e[:stationId] }

  #           if b.length > 1
  #             count1h  = count1h + (b.length - 1)
  #             # p b.length
  #             # p "                           "
  #             # p "                           "
  #             # p "                           "
  #             # p b
  #           end
  #         end
  #       end

  #       if lastHourBikes.count > 0
  #         fileWrite.write( (hour).to_s + "," + (hour+3).to_s + "," +  count1h.to_s + " \n")
  #       end
  #     end
  #   end
  # end
  # fileWrite.close

  # p 'Liczba unikalnych wierszy w ostatnich 3 godzinach ' + lastHourBikes.length.to_s

  # count = 0

  # bikeNumbers.each do |bike|
  #   a = []
  #   uniqSort.each do |el|
  #     if !(el[:bike_numbers].nil?) and el[:bike_numbers].include? bike.to_s
  #       a << el
  #     end
  #   end
  #   if a.length > 1
  #     b = a.uniq {|e| e[:stationId] }

  #     if b.length > 1
  #       count  = count + (b.length - 1)
  #       # p b.length
  #       # p "                           "
  #       # p "                           "
  #       # p "                           "
  #       # p b
  #     end
  #   end

  # end
  # p 'Liczba wykrytch zmian rowerow na stacjach ' + count.to_s

  # count1h = 0


  # bikeNumbers.each do |bike|
  #   a = []
  #   lastHourBikes.each do |el|
  #     if !(el[:bike_numbers].nil?) and el[:bike_numbers].include? bike.to_s
  #       a << el
  #     end
  #   end
  #   if a.length > 1
  #     b = a.uniq {|e| e[:stationId] }

  #     if b.length > 1
  #       count1h  = count1h + (b.length - 1)
  #       # p b.length
  #       # p "                           "
  #       # p "                           "
  #       # p "                           "
  #       # p b
  #     end
  #   end
  # end
  # p 'Liczba wykrytch zmian rowerow w ostatnich 3 godzinach ' + count1h.to_s

end