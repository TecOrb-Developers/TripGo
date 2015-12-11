module ApplicationHelper

	def radio_checked?(type,val)
	  case type
	    when 'system'
	      ['bacteria', 'mammalian', 'yeast', 'insect'].include?(val) ? '' : 'checked'               
	    end
	  end

	def text_input?(type,val)
	  case type
	    when 'system'
	      ['bacteria', 'mammalian', 'yeast', 'insect'].include?(val) ? '' : val
	  end       
	end

	def formated_datetime date
    date.strftime('%I:%M %p %d %b \'%y')
  end

  def formated_date date
    date.strftime('%d %b \'%y')
  end

  # work pending for custom pagination----- :P :D
  def demo_p collection
  	content_tag :ul, :class => "pagination pagination-lg" do
  		total_page = collection.total_pages
  		current_page = collection.current_page
  		last_page = collection.total_pages - 1

  		total_page.times do |t|
  			content_tag :li do
  				css_class = ((t == 0 or t == last_page) ? "pager-active" : ((t == current_page) ? "pager-selected" : ""))
            link_to((t == 0) ? "Prev" : ((t == last_page) ? "Next" : h+1), '#', :class=> css_class)
            # link_to "ds", '#'
  			end
  		end

  	end
  	# html
		# <ul class="pagination pagination-lg">
		# 	<li><a href="#" class="pager-active">Prev</a></li>
		# 	<li><a href="#" class="pager-selected">1</a></li>
		# 	<li><a href="#">2</a></li>
		# 	<li><a href="#">3</a></li>
		# 	<li><a href="#">4</a></li>
		# 	<li><a href="#">5</a></li>
		# 	<li><a href="#" class="pager-active">Next</a></li>
		# </ul>
  	
  end

  def current_city
    "Delhi"
    # unless params[:base_city].present?
  	 # request.location.present? ? request.location.city : "Delhi"
    # else
    #   params[:base_city]
    # end
  end

  def serial_for_paginatation current_page, per_page
    current_page == 1 ? 1 : (current_page * per_page) - per_page+1
  end

  def all_cities_in package
    package.cities.pluck(:city_name).join(" - ")
  end

  def all_holiday_destination_in package
    package.holidays.join(" - ")
  end

  def all_transport_mode_in package
    package.transports.pluck(:transport_mode).uniq.join(" - ") 
  end

  def all_hotel_rating_in package
    package.hotels.pluck(:rating).max
  end

  def local_transport_mode package
    package.city_transports.first.transport_mode.nil? ? 'Not Included' : package.city_transports.first.transport_mode
  end

  def all_local_city_transports_in package
    package.city_transports.where(:city_transpotation => 'included').pluck(:transport_mode).join(" - ")
  end

  def meal_type_in package
    package.meal.meal_type
  end

  def all_sight_scenes_in package
    (package.included.include? 'SI') ? 'Included' : 'Not Included'
  end

  def duration_of package
    package.package_duration.split(' ').first(2).join(' ')
  end

  def total_operators_of packages
    packages.map(&:user_id).uniq.count
  end

  def is_searched_for? current_element, searched_for
    searched_for.include?(current_element) ? true : false if searched_for
  end

  def operator_name_of package
    package.user.name.titleize
  end

  def operator_since package
    package.created_at.strftime("%Y") 
  end

  def operator_profile_of package
    package.user.profile
  end

  def get_inclusion_of package
    package.inclusion
  end

  def set_category
    ['abc','def']
  end

  def tour_operators(packages)
    operators = Package.all.map(&:user_id).uniq
    return User.find(operators).map(&:name)
  end

  def sight_scenes_in package
    package.sight_scenes.where(:included => "included")
  end

  def validity_of package
    "#{formated_date package.start_date} - #{ formated_date package.end_date}"
  end

  def price_of package
    number_to_currency(package.price_per_person,  unit: "Rs.")
  end

  def extra_charge_in package
    number_to_currency(package.extra_cost != '0.0' ? package.extra_cost : '0', unit: "Rs.")
  end

  def notification_icon_for type
    case(type)
    when "Enquiry"
      return "crm.png"
    when "Package"
      return "pack.png"
    when "Offer"
      return "offers.png"
    when "Profile"
      return "profile.png"
    else
      return "pack.png"
    end
  end

  def notification_url_for type, id
    case(type)
    when "NEW_LEAD"
      return link_to 'view', crms_path, :class=> "noti_link"
    when "PACKAGE_APPROVED"
      return link_to 'view', inclusion_path(id), :class=> "noti_link"
    when "PACKAGE_DISAPPROVED"
      return link_to 'view', edit_package_path(id), :class=> "noti_link"
    when "PROFILE_APPROVED"
      return link_to 'view', edit_suplier_path(id), :class=> "noti_link"
    when "PACKAGE_DISAPPROVED"
      return link_to 'view', edit_suplier_path(id), :class=> "noti_link"
    else
      return "pack.png"
    end
  end

end
