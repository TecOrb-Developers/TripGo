class SightScenesController < ApplicationController
	
	before_action :authenticate_user!

	def edit
		@package = Package.find params[:id]
	end

	def update
		@package = Package.find_by_id(params[:id])
		if SightScene.update(params[:sight_scenes].keys, params[:sight_scenes].values).reject { |p| p.errors.empty? }
			params[:commit] == "Save" ?  (redirect_to edit_sight_scenes_path(@package),:notice => "Successfully Updated") : (redirect_to edit_itineraries_path(@package),:notice => "Successfully Updated")
		else
			redirect_to :back
			flash[:notice] = "errsight_scenes updated"
		end
		
	end
end
