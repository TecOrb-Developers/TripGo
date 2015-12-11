class Profile < ActiveRecord::Base
	belongs_to :user
	before_save :reject_blank
	mount_uploader :logo, PictureUploader

	def reject_blank
		self.category.reject! { |c| c.empty? }
		self.specilized_in.reject! { |c| c.empty? }
	end

end
