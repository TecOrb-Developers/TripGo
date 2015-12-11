class Transport < ActiveRecord::Base
  belongs_to :package
  

  TRANSPORT_MODE = ['Flights', 'Train','Bus','Exclusive Private Vehicle','No Transport','Others']
  AIRLINE = ['Indigo','Air India','SpiceJet','Jet light','GoAir', 'Jet Airways', 'Asia Airlines','Others']
  TRAIN = ['1 A/C','Sleeper','2 A/C','A/C Chair Car','3 A/C', 'Non A/C Chair Car', 'Others']
  BUS = ['A/C Volvo','Non A/C','A/C Non Volvo','Sleeper','Others']
  PRIVATE_VEHICLE = ['A/C SUV','A/C Hatchback','Non A/C SUV','Non A/C Hatchback','A/C Sedan','Non A/C Sedan','A/C Coach','Non A/c Coach','Others']
  TYPE_OF_VEHICLE = ['Volvo','Train']
  TIME_OF_ONWAED = ['Early Morning','Morning','Afternoon', 'Evening', 'Night']
  
   after_save :add_inclusion

   def add_inclusion
   		array_code = []
		self.transport_mode != 'No Transport' ? array_code << 'ICTM' : true
		self.transfer_section == 'included' ? array_code << 'ICTS' : true
		
		self.package.update_attributes(:included => (self.package.included+array_code).uniq)
   end

end
