class SightScene < ActiveRecord::Base
  belongs_to :package
mount_uploader :picture, PictureUploader
  # has_one :picture, as: :imagiable, dependent: :destroy
  # accepts_nested_attributes_for :picture, allow_destroy: true

  SIGHT_SCENES = [:scene1, :scene2, :scene3]
  GUIDES = [:Guide1, :Guide2, :Guide3]
  after_save :add_inclusion
   def add_inclusion
   		array_code = []
		self.included == 'included' ? array_code << 'SS' : true
		self.package.update_attributes(:included => (self.package.included+array_code).uniq)
   end
end