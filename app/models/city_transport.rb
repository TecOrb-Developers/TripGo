class CityTransport < ActiveRecord::Base
  belongs_to :package
  belongs_to :city

  TRANSPORT_MODES = ['A/C SUV','A/C Hatchback','Non A/C SUV','Non A/C Hatchback','A/C Sedan','Non A/C Sedan','A/C Coach','Non A/c Coach','Other']
  after_save :add_inclusion

   def add_inclusion
   		array_code = []
		self.city_transpotation == 'included' ? array_code << 'CT' : true
		self.package.update_attributes(:included => (self.package.included+array_code).uniq)
   end
end
