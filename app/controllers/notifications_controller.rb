class NotificationsController < ApplicationController

	before_action :authenticate_user!

	def index
    authorize! :see_notifications, current_user
		@notifications = current_user.my_notifications
		 current_user.my_notifications.update_all(is_viewed: true)
	end
end
