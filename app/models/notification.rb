class Notification < ActiveRecord::Base
	belongs_to :notifiable, polymorphic: true

	def self.create_notification(sender,reciever,type,poly)
		poly.notifications.create(:sender => sender, :reciever => reciever, 
			:action_type=> type, :is_viewed => false, :message =>  alert(type) ) 
	end

	
	def self.alert(type)
		case(type)
		when "PACKAGE_APPROVED"
			return "Your Packkage has been approved by Admin"
		when "PACKAGE_DISAPPROVED"
			return "Your Packkage has been disapproved by Admin"
		when "NEW_LEAD"
			return "You have one new lead"
		when "PROFILE_APPROVED"
			return "Your Profile has been approved by Admin"
		when "PACKAGE_DISAPPROVED"
			return "Your Profile has been disapproved by Admin"
		else
			return "default message"
		end
	end
end
