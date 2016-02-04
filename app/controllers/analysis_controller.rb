class AnalysisController < ApplicationController

  def availability
  	@result = Bikehistory.count_avaliability(params[:stationName], params[:period])
  end

  def agglomerative

  end

  def kmeans

  end

end
