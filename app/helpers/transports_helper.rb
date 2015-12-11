module TransportsHelper
	def get_transport_mode stored_value
		Transport::TRANSPORT_MODE.include?(stored_value) ? "" : stored_value
	end

	def get_private_transport_name stored_value,mode
		if (mode != 'Exclusive Private Vehicle')  
			""
		else
			Transport::PRIVATE_VEHICLE.include?(stored_value) ? "" : stored_value
		end
		# Transport::PRIVATE_VEHICLE.include?(stored_value) ? "" : stored_value
	end	

	def get_airline_transport_name stored_value,mode
		if (mode != 'Return Flights')
			""
		else
			Transport::AIRLINE.include?(stored_value) ? "" : stored_value
		end
		# Transport::AIRLINE.include?(stored_value) ? "" : stored_value
	end

	def get_train_transport_name stored_value,mode
		if (mode != 'Return Train Tickets')
			""
		else
			Transport::TRAIN.include?(stored_value) ? "" : stored_value
		end
		# Transport::TRAIN.include?(stored_value) ? "" : stored_value
	end

	def get_bus_transport_name stored_value,mode
		if (mode != 'Return Bus Tickets')
			""
		else
			Transport::BUS.include?(stored_value) ? "" : stored_value
		end
		# Transport::BUS.include?(stored_value) ? "" : stored_value
	end

	def get_transfer_mode stored_value
		Transport::PRIVATE_VEHICLE.include?(stored_value) ? "" : stored_value
	end
end