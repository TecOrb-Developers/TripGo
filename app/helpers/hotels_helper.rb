module HotelsHelper
	
	def city_names
		@package.cities.pluck(:city_name) - Array(@package.cities.first.city_name)
	end

	def collection_rating
		["2 Stars","3 Stars","4 Stars","5 Stars"]
	end

	def hotel_amenities
		["Safe/Vault","Casino","Game Room","24 Hour Security","Baby Sitting","Kids Area",
		 "Coffee Shop","Paid Laundry","Travel Desk","Disco","Golfing Amenities","Steam and Sauna",
		 "Steam and Sauna","Smoking Rooms","Business Center","Wheelchair Access","Bar/Lounge",
		 "Currency Exchange","Doctor on Call","Valet Parking","Swimming Pool","Children Swimming Pool","Shops"]
	end

	def room_amenities
		["Balcony","Bathtub","Shower","Room Internet","Television","Study Desk",
		 "Newspaper","Minibar","Telephone","Sitting Area","Iron and Ironing Board","Hair Dryer",
		 "Room Vault","Air Conditioning","Toiletries","DVD","Wake up Service",
		 "Tea/Coffee","Kettle"]
	end

	def get_hotel_rating stored_value
		collection_rating.include?(stored_value) ? "" : stored_value
	end
	
end
