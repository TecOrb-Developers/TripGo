module CityTransportsHelper
	def get_city_transport_mode stored_value
		CityTransport::TRANSPORT_MODES.include?(stored_value) ? "" : stored_value
	end
end
