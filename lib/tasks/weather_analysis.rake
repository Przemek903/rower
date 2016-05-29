desc "Weather anlysis"
task :weather_analysis => :environment do
    # Słaba optymalizacja !!!!!!!!!!!!!!!!!!!!!!!!!!
    stations = Station.all
    whole = 0
    Weather.all.each do |weat|
      bikehistories = Bikehistory.where(created_at: weat.weather_date.beginning_of_day..weat.weather_date.end_of_day)
      count = 0
      stations.each do |stat|
        actualbikehistories = bikehistories.where(name: stat.name)
        if actualbikehistories.present?
          actualBikeNumber = bikehistories.first.bike_numbers
          actualbikehistories.each do |bike|
            if actualBikeNumber != bike.bike_numbers
              count = count + 1
            end
            actualBikeNumber = bike.bike_numbers
          end
        end
      end
      # p weat.weather_date
      # p count
      weat.update_attributes(count: count)
    end
end