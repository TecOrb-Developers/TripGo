class DashboardController < ApplicationController

before_action :authenticate_user!
	def mainboard
		
	end

	def menu_board
		authorize! :see_mainboard, current_user
	end
end
