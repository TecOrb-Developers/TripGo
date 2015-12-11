class InclusionsController < ApplicationController
  
  before_action :authenticate_user!

  def edit_inclusion
    @inclusion = Inclusion.find(params[:id])
  end

  def update_inclusion
  	@inclusion = Inclusion.find(params[:id])
  	if @inclusion.update_attributes(inclusion_params)
  		redirect_to packages_path ,:notice => 'Package is successfully saved !'
  	else
  		render :edit_inclusion
  	end
  end

  private
  def inclusion_params
    params.require(:inclusion).permit!
  end

end
