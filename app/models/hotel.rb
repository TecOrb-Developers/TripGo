class Hotel < ActiveRecord::Base
  belongs_to :package
  has_many :pictures, as: :imagiable, dependent: :destroy
  accepts_nested_attributes_for :pictures, allow_destroy: true 
  after_save :add_inclusion 
    def add_inclusion
   		array_code = []
   		logger.info "=======#{self.hotel_name}==#{self.hotel_name.present?}======="
		self.hotel_name.present? ? array_code << 'HT' : true
		self.package.update_attributes(:included => (self.package.included+array_code).uniq)
    end
end
