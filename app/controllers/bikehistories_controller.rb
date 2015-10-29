class BikehistoriesController < ApplicationController
	def index
		@bikehistories = Bikehistory.all
	end
end
