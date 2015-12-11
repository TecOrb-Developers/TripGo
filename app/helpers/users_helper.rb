module UsersHelper

	def get_category stored_value
		stored_value - User::CATEGORIES
	end

	def get_specilized stored_value
		stored_value - User::SPECILIZED
	end
end
