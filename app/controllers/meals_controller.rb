class MealsController < ApplicationController
	
	before_action :authenticate_user!
	
	def edit
		@package = Package.find params[:id]
	end

	def update
		@package = Package.find params[:id]
		 if @package.meal.update(meal_params)
			params[:commit] == "Save" ?  (redirect_to edit_meals_path(@package),:notice => "Successfully Updated") : (redirect_to edit_sight_scenes_path(@package),:notice => "Successfully Updated")
		else
			redirect_to :back
			flash[:notice] = "err meals updated"
		end
	end

	def meal_params
		params.require(:meal).permit(:meal_type)
	end
end
