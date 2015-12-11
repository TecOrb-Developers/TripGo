class HotelsController < ApplicationController

before_action :authenticate_user!
	def add_hotel
		@package = Package.find(params[:id])
		if @package.hotels.blank?
			@hotels = @package.hotels.build
		else
			@hotels = @package.hotels
		end
	end

	def update_hotel
		@package = Package.find(params[:id])
		@package.update_attributes(package_params)
		params[:commit] == "Save" ?  (redirect_to :back,:notice => "Successfully Updated") : (redirect_to edit_meals_path(@package),:notice => "Successfully Updated")
	end


	private

	  def package_params
	    params.require(:package).permit!
	  end
end
