class PagesController < ApplicationController
  before_action :authenticate_user!

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
