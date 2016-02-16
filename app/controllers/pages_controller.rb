class PagesController < ApplicationController
  before_action :authenticate_user!

# [[52.2220669137432, 21.0343900322914], [52.2206291530742, 20.9722995758057],
# [52.2291597327569, 21.0053819417953], [52.2276942721007, 21.0442095994949],
# [52.2325439077234, 20.9833288192749], [52.2365388734892, 21.0648250579834],
# [52.2527384528817, 21.0511082410812], [52.2372550382261, 20.9888648986816],
# [52.2421956030102, 20.9929901361465], [52.2387168982644, 21.0508292913437],
# [52.2559960480504, 20.9833288192749], [52.2950488462447, 20.9594786167145],
# [52.2513854297334, 20.9857803583145], [52.2907900937393, 20.9296256303787],
# [52.2083397407122, 20.9631371498108]]


# [[52.1992889574219, 21.0121947526932], [52.2016989537481, 20.9821432828903],
# [52.2083397407122, 20.9631371498108], [52.2907900937393, 20.9296256303787],
# [52.2951013398688, 20.9594786167145], [52.2527384528817, 21.0511082410812],
#  [52.2365388734892, 21.0648250579834], [52.1995191127835, 21.0513067245483]]



  def new
  	@station = Station.all
  	@hash = Gmaps4rails.build_markers(@station) do |station, marker|
	  marker.lat 		station.lat
	  marker.lng 		station.lng
	  marker.picture({
        :url     => "/assets/man459.png",
        :width   => 32,
        :height  => 32
        })
	  marker.infowindow render_to_string(:partial => "pages/infowindowPartial", :locals => { :station => station})
	end
  end
end
