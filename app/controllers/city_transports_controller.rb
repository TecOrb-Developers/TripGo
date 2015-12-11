class CityTransportsController < ApplicationController

before_action :authenticate_user!


	def edit_city_transport
		@package = Package.find(params[:id])
		@city_transports = @package.city_transports
	end

	def update
		@package = Package.find_by_id(params[:id])
		if CityTransport.update(params[:city_transports].keys, params[:city_transports].values).reject { |p| p.errors.empty? }
			params[:commit] == "Save" ?  (redirect_to edit_city_transports_path(@package),:notice => "Successfully Updated") : (redirect_to edit_hotel_path(@package),:notice => "Successfully Updated")
		else
			redirect_to :back
			flash[:notice] = "errProducts updated"
		end
	end
end
