class ItinerariesController < ApplicationController
	
before_action :authenticate_user!

	def edit
		@package = Package.find params[:id]
	end

	def update
		@package = Package.find_by_id(params[:id])
		if Itinerary.update(params[:itineraries].keys, params[:itineraries].values).reject { |p| p.errors.empty? }
			params[:commit] == "Save" ?  (redirect_to edit_itineraries_path(@package),:notice => "Successfully Updated") : (redirect_to edit_inclusion_path(@package.inclusion),:notice => "Successfully Updated")
		else
			redirect_to :back
			flash[:notice] = "err Itineraries"
		end
		
	end
end
