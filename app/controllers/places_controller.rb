class PlacesController < ApplicationController
	def index
	end
	
	def search
		@places = BeermappingApi.places_in(params[:city])
		session[:last_search_city] = params[:city]
    	if @places.empty?
      	redirect_to places_path, notice: "No locations in #{params[:city]}"
    	else
      	render :index
    	end
	end
	
	def show
		@place = BeermappingApi.places_in(session[:last_search_city]).select { |p| p.id == params[:id]}.first
	end
end