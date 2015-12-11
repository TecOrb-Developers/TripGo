class Picture < ActiveRecord::Base
	belongs_to :imagiable, polymorphic: true
	mount_uploader :image, ImageUploader
end
