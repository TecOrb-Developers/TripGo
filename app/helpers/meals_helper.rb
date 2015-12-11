module MealsHelper
	def get_other_meal stored_value
		Meal::MEALS.include?(stored_value) ? "" : stored_value
	end
end
