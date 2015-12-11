module PackagesHelper
	def package_duration
		['2 Nights 3 Days','3 Nights 4 Days','4 Nights 5 Days','5 Nights 6 Days','6 Nights 7 Days']
	end

	def get_room_sharing stored_value
		Package::ROOM_SHARING.include?(stored_value) ? "" : stored_value
	end

	def sortable(column, title = nil)
	    title ||= column.titleize
	    arrow_class = sort_direction == "asc" ? "fa fa-arrow-down" : "fa fa-arrow-up"
	    css_class = column == sort_column ? "current #{sort_direction} #{arrow_class}" : nil
	    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
	    link_to title, params.merge(:sort => column, :direction => direction), {:class => "#{css_class} sortable"}
    end
  

end
