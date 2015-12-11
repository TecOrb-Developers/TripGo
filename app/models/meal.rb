class Meal < ActiveRecord::Base
	belongs_to :package
	MEALS = ["No Meals", "Daily Breakfast Buffet", "Breakfast + lunch / dinner", "All Meals", "Other"]
	# after_save :add_inclusion

 #   def add_inclusion
 #   		array_code = []
	# 	self.meal_type != 'No Meals' ? array_code << 'Meal' : true
	# 	self.package.update_attributes(:included => (self.package.included+array_code).uniq)
 #   end
end