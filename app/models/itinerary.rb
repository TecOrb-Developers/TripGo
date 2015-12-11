class Itinerary < ActiveRecord::Base
  belongs_to :package
	mount_uploader :picture, PictureUploader
  
end
