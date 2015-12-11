class TransportsController < ApplicationController
	
	before_action :authenticate_user!

	def edit
		@package = Package.find(params[:id])
	end

	def update
		@package = Package.find_by_id(params[:id])
		if Transport.update(params[:transports].keys, params[:transports].values).reject { |p| p.errors.empty? }
			params[:commit] == "Save" ?  (redirect_to edit_transport_path(@package),:notice => "Successfully Updated") : (redirect_to edit_city_transports_path(@package),:notice => "Successfully Updated")
		else
			redirect_to :back
			flash[:notice] = "errProducts updated"
		end
	end
end
