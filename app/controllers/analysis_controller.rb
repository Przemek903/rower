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

  def weather
    hireNumbers = Weather.all.group(:avg_temp).order('avg_temp asc').sum(:count)
    dayNumbers = Weather.all.group(:avg_temp).order('avg_temp asc').count(:count)
    @avg_count = {}
    hireNumbers.each do |k,v|
      intOfK = k.to_i
      @avg_count[intOfK] = v/dayNumbers[k]
    end

    @weatherAndCount = Weather.all.group(:conditions).sum(:count)

    @countWeather = {}
    weathers = ['deszcz', 'mgła', 'burza', 'śnieg', 'grad']
    weathers.each do |weat|
      days = Weather.where('conditions LIKE ?', '%'+weat+'%').count
      suma = Weather.where('conditions LIKE ?', '%'+weat+'%').sum(:count)
      @countWeather[weat] = suma/days
    end
    @countWeather['brak'] = Weather.where(conditions: nil).sum(:count)/Weather.where(conditions: nil).count
  end

  def hiretime
    #toDo
  end

  def traffic
    @mostPopularTraffic = ClusterTraffic.where.not(count: nil).group(:id).order(:count).last(10).reverse
  end
end
