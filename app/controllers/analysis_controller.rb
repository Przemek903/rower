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
    @lessHireToRake= Station.where('"hireCount" > ?', 50).order(:hireRack).limit(5)
    @topHireToRake = Station.where('"hireCount" > ?', 50).order(:hireRack).reverse_order.limit(5)
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
      if days == 0
        @countWeather[weat] = 0
      else
        @countWeather[weat] = suma/days
      end
    end
    @countWeather['brak'] = Weather.where(conditions: nil).sum(:count)/Weather.where(conditions: nil).count
  end

  def hiretime
    #toDo
  end

  def traffic
    @kmeans = Station.count_convex_kmean
    @mostUsedTrafficsTwoWays = TwoDirectionTraffic.order(:totalCount).last(10).reverse
    @startAndLineProperties = []
    @end = []
    @lineColor = []
    @clusterInfo = []
    TwoDirectionTraffic.order(:totalCount).last(126).each do |traffic|
      startCluster = ClusterKMean.find(traffic.stationA_id)
      endCluster = ClusterKMean.find(traffic.stationB_id)
      lineWeight = 1

      case traffic.totalCount
      when 1..500
        lineWeight = 0.7
        @lineColor << "#703982"
      when 501..1000
        lineWeight = 1
        @lineColor << "#417F94"
      when 1001..2000
        lineWeight = 2
        @lineColor << "#50A334"
      when 2001..2500
        lineWeight = 3
        @lineColor << "#ADFC00"
      when 2501..3000
        lineWeight = 4
        @lineColor << "#F0D83C"
      when 3001..5000
        lineWeight = 5
        @lineColor << "#F0993C"
      else
        lineWeight = 6
        @lineColor << "#F52222"
      end
      @startAndLineProperties << [startCluster.lat, startCluster.lng, lineWeight]
      @end << [endCluster.lat, endCluster.lng]
      @clusterInfo << [
                        traffic.fromFirstToSecond, traffic.formSecondToFirst,
                        startCluster.numberOfStations, endCluster.numberOfStations,
                        Station.where(clusterKMean_id: traffic.stationA_id).first.name,
                        Station.where(clusterKMean_id: traffic.stationB_id).first.name,
                        traffic.stationA_id, traffic.stationB_id
                      ]
    end
    @polylines = []
    @topImport, @topExport = findTopImportAndExport
  end

  private

    def findTopImportAndExport
      numberOfClusters = 50
      totalImportToClusters = {}
      totalExportForClusters = {}
      (1..numberOfClusters).each do |clusterNumber|
        importSum = 0
        exportSum = 0
        clusterImportTraffics = ClusterTraffic.where(toCluster: clusterNumber)
        clusterExportTraffics = ClusterTraffic.where(fromCluster: clusterNumber)
        clusterImportTraffics.each do |importCluster|
          importSum = importSum + importCluster.count
        end
        clusterExportTraffics.each do |exportCluster|
          exportSum = exportSum + exportCluster.count
        end
        totalImportToClusters[clusterNumber] = importSum
        totalExportForClusters[clusterNumber] = exportSum
      end
      return totalImportToClusters.sort_by {|_key, value| value}.reverse, totalExportForClusters.sort_by {|_key, value| value}.reverse
    end
end
