class HomeController < ApplicationController
  def index
    #@packages = Package.today_onwards.all
    params[:place_from].nil? ? @place = 'Delhi': @place = params[:place_from]
    @packages = Package.all
    if current_user
      wishlists = current_user.wishlists.pluck(:package_id)
      comparelist= current_user.packages_for_compare.pluck(:package_id)
      @packages = @packages.each { |e| e.update_attributes(:is_in_wishlist =>  wishlists.include?(e.id) ? true : false, :is_in_comparelist =>  comparelist.include?(e.id) ? true : false) }
    end
    @reccomended_center = @packages.map{|x| x if x.recommended_center == true}.compact
    @reccomended_side = @packages.map{|x| x if x.recommended_side == true}.compact
    @packages_start_with = @packages.map{|x| x if ( x.cities.first.city_name == @place)}.compact
    @weekend_gataways = @packages_start_with.map{|x| x if (x.tag_as_weakend)}.compact
  end

  def new ; end

  def find_city
  	render :json => {:cities =>  StateCity.pluck(:city)}
  end

  def search
    authorize! :search, current_user
    base_city = params[:base_city]
    start_date = params[:date].to_date
    destnation_city = params[:destination]
    duration = params[:nights].present? ?  "#{params[:nights]} Nights #{params[:nights].to_i+1} Days": ''

    holiday_types = params[:holiday_types] ||= []
    destination_types = params[:destination_types] ||= []
    inclusions = params[:inclusions] ||= []
    hotel_rating = params[:hotel_rating] ||= []
    sort_by = params[:sort_by] ||= ''
    price_range = params[:price_range].split(';') if params[:price_range]
    operators = params[:operators] || User.supplier.pluck(:name)

    unless params[:is_filter].present?
      @packages = Package.search_by(base_city, destnation_city, start_date, duration, sort_by)
      min_price = @packages.map(&:price_per_person).min
      max_price = @packages.map(&:price_per_person).max
      session[:obj] ||={}
      session[:obj]['min_price'] = @packages.map(&:price_per_person).min || 0
      session[:obj]['max_price'] = @packages.map(&:price_per_person).max || 5000000
      session[:obj]['price_range'] = "#{session[:obj]['min_price']};#{session[:obj]['max_price']}"
    else
      @packages = Package.filter_by(destination_types, holiday_types, inclusions, hotel_rating, sort_by.downcase)
      @packages = @packages.map{ |x| x if (x.price_per_person.between?(price_range[0].to_f,price_range[1].to_f) && x.user.name.in?(operators))}.compact
    end
    if current_user
      wishlists = current_user.wishlists.pluck(:package_id)
      comparelist= current_user.packages_for_compare.pluck(:package_id)
      @packages = @packages.each { |e| e.update_attributes(:is_in_wishlist =>  wishlists.include?(e.id) ? true : false, :is_in_comparelist =>  comparelist.include?(e.id) ? true : false) }
    end
  end

  def delete_wishlist
    if params[:is_all] == 'false'
      current_user.wishlists.find_by_package_id(params[:package_id].to_i).destroy
      count = current_user.wishlists.count
      current_user.remove_from_crm params[:package_id].to_i, "Wishlist"
    else
      # current_user.wishlists.destroy_all
      wishlists = current_user.wishlists
      wishlists.each{ |e| current_user.remove_from_crm e.package_id, "Wishlist" }
      wishlists.destroy_all
      count = 0
    end
    render :json=> {:count => count}
  end

  def add_to_wishlist
    authorize! :can_add_to_wishlist, current_user
    wishlist = current_user.wishlists.find_by_package_id(params[:package_id])
    if wishlist
      current_user.wishlists.find_by_package_id(params[:package_id]).destroy
      current_user.remove_from_crm params[:package_id].to_i, "Wishlist"
      count = current_user.wishlists.count
      status = false
    else
      current_user.wishlists.create(:package_id => params[:package_id])
      current_user.add_to_crm params[:package_id], "Wishlist"
      count = current_user.wishlists.count
      status = true
    end
    render :json => {:status => status, :count => count}
  end


  def wishlist
    authorize! :can_see_wishlist, current_user
    sort_by = params[:sort_by] ? (Package::SORT_BY.has_value?(params[:sort_by]) ? params[:sort_by] : 'price_per_person') : 'price_per_person'
    package_ids_in_wishlists = current_user.wishlists.pluck(:package_id)
    packages = Package.where(id: package_ids_in_wishlists)

    comparelist= current_user.packages_for_compare.pluck(:package_id)
    # wishlists = current_user.wishlists.pluck(:package_id)
    packages = packages.each { |e| e.update_attributes(:is_in_wishlist =>  package_ids_in_wishlists.include?(e.id) ? true : false, :is_in_comparelist =>  comparelist.include?(e.id) ? true : false) }
    @packages = packages.sort_by { |s| s.send(sort_by) } unless sort_by == 'city_name'
    @packages = packages.sort_by { |s| s.cities.last.city_name } if sort_by == 'city_name'
  end

  def comparision
    authorize! :can_see_wishlist, current_user
    packages_for_compare = current_user.packages_for_compare.pluck(:package_id)
    redirect_to :back, :alert=>"You need atleast 2 packages for comparision." if packages_for_compare.length <= 1
    if params[:package_id] and packages_for_compare.include?(params[:package_id].to_i)
# NOTE: must be Atleast two packages there
        add_remove_compare and redirect_to :back # if packages_for_compare.length >= 3  
      else
        packages = Package.where(:id => packages_for_compare)
        wishlists = current_user.wishlists.pluck(:package_id)
        @packages = packages.each { |e| e.update_attributes(:is_in_wishlist =>  wishlists.include?(e.id) ? true : false, :is_in_comparelist =>  packages_for_compare.include?(e.id) ? true : false) }
      end

    end

    def add_remove_comparision
      authorize! :can_add_to_wishlist, current_user
      status, count = add_remove_compare
      render :json => {:status => status, :count => count}
    end

    def is_valid_to_compare
      render :json => {:count => current_user.packages_for_compare.count}
    end

    def enquiry
      authorize! :can_enquiry, current_user
      @enquiry = Enquiry.find_or_create_by(enquiry_params)
      current_user.add_to_crm enquiry_params[:package_id], 'Enquiry'
    # notification
    package_owner = Package.owner_of enquiry_params[:package_id]
    Notification.create_notification(current_user.id, package_owner.id, "NEW_LEAD", @enquiry) if current_user != package_owner

    redirect_to :back ,:notice => 'Successfully submited!'
  end

  def get_enquiry_detail
    @enquiry = Enquiry.get_enquiry params[:user_id], params[:package_id]
    respond_to do |format|
      format.js
    end
    
  end

  def about_us;  end

  def become_our_partner;  end

  def become_partner;  end

  def career; end

  def terms_condition; end

  def team; end

  def website; end

  def contact_us; end

  def our_partner; end

  def affiliate_program; end

  def partner_model; end

  def view_on_map
    @hotel = Hotel.find_by_id(params[:id])
    @address = @hotel.hotel_name + " " + @hotel.city
  end


  def complaint
    Complaint.create(complaint_params)
    UserMailer.complaint(complaint_params).deliver
    redirect_to :back ,:notice => 'Successfully submited!'
  end

  private 
  def enquiry_params
    params.require(:enquiry).permit!
  end

  def complaint_params
    params.require(:complaint).permit!
  end

  def add_remove_compare
    package_for_compare = current_user.packages_for_compare.find_by_package_id(params[:package_id])
    if package_for_compare
      package_for_compare.destroy
      current_user.remove_from_crm params[:package_id].to_i, "Compare"
      count = current_user.packages_for_compare.count
      status = false
    else
      current_user.packages_for_compare.create(:package_id => params[:package_id])
      current_user.add_to_crm params[:package_id], "Compare"
      count = current_user.packages_for_compare.count
      status = true
    end
    return status, count
  end
end
