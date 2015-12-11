class PackagesController < ApplicationController
	include SimilarPackagesAlgorithm
	$per_page = 15
	before_action :authenticate_user! , except: [:approve_package,:recommended_side]
	def index
		@packages = current_user.packages.order('itinerary_name desc').paginate(:page => 1, :per_page => $per_page)
	end

	def new	
		@package = Package.new
		@cities = @package.cities.build
		@pictures = @package.pictures.build
	end

	def create
		@package = current_user.packages.build(package_params)
		if @package.save
			@package.create_transport('create')
			@package.in_city_transport('create')
			@package.sight_secne('create')
			@package.create_itineraries('create')
			@package.create_meall('create')
			params[:commit] == "Save" ?  (redirect_to edit_package_path(@package),:notice => "Successfully created") : (redirect_to edit_transport_path(@package),:notice => "Successfully created")
		else
			render :new
		end
	end

	def edit
		@package = Package.find(params[:id])
		@cities = @package.cities
		@pictures = @package.pictures
	end

	def update
		@package = Package.find(params[:id])
		if  @package.update_attributes(package_params)
			 	@package.create_transport('update')
			 	@package.in_city_transport('update')
			params[:commit] == "Save" ? (redirect_to edit_package_path(@package), :notice => "Successfully updated") : (redirect_to edit_transport_path(@package),:notice => "Successfully updated")
		else
			render :edit
		end
	end

	def packages_filter
		filter_against = params[:filter_against]
		filter_query = params[:filter_query]
		page = params[:page]
		per_page = 2
		packages= []
		if filter_query
			if filter_against.downcase == 'name'
				packages = Package.search(filter_query, current_user.my_packages_ids).order(sort_column + " " + sort_direction).paginate(:page => page, :per_page => $per_page)
			else
				packages_ids = City.packages_by_destination(filter_query, current_user.my_packages_ids)
				packages = Package.search_by_ids(packages_ids).order(sort_column + " " + sort_direction).paginate(:page => page, :per_page => $per_page)
			end
		else
			packages = current_user.packages.paginate(:page => page, :per_page => $per_page)
		end

		respond_to do |format|
			format.js{ render "packages_filter", :locals => {:packages => packages} }
		end
	end

	def destroy
		@package = Package.find(params[:id])
		@package.destroy
		packages = current_user.packages.paginate(:page => 1, :per_page => $per_page)

		respond_to do |format|
			format.js{ render "packages_filter", :locals => {:packages => packages} }
		end
	end

	def duplicate_package
		package = Package.find(params[:id]).clone_with_associations
		package.save
		packages = current_user.packages.order(sort_column + " " + sort_direction).paginate(:page => 1, :per_page => $per_page)

		respond_to do |format|
			format.js{ render "packages_filter", :locals => {:packages => packages} }
		end
	end

	def inclusions
		@package = Package.find_by_id(params[:id])
		wishlists = current_user.wishlists.pluck(:package_id)
		comparelist= current_user.packages_for_compare.pluck(:package_id)
		@package.update_attributes(:is_in_wishlist =>  wishlists.include?(@package.id) ? true : false, :is_in_comparelist =>  comparelist.include?(@package.id) ? true : false)
		@similar_packages = similar_packages(@package)
	end

	def approve_package
		package = Package.find(params[:id])
		package.update_attributes(:status=> !package.status)

    # notification
    package_owner = package.user.id
    action_type = package.status? ? 'PACKAGE_APPROVED' : 'PACKAGE_DISAPPROVED' 
    Notification.create_notification(current_admin_user.id, package_owner, action_type, package) if current_admin_user != package_owner

		redirect_to admin_packages_path
	end

	def inventory
	  @package = Package.find_by_id(params[:package_id])
	  @package.update_attributes(:inventory => params[:inventory]) 
	  render :json => true
	end

	# AdminPanel actions
	def approve_package
		package = Package.find(params[:id])
		package.update_attributes(:status => !package.status)
		redirect_to admin_packages_path
	end

	def recommended_side  
		package = Package.find(params[:package_id])
		package.update_attributes(:recommended_side => !package.recommended_side) if params[:recommended_for].downcase == "side"
		package.update_attributes(:recommended_center => !package.recommended_center) if params[:recommended_for].downcase == "center"
		render :json => {:status => true}
	end

	helper_method :sort_column, :sort_direction
	private
	def package_params
		params.require(:package).permit!
	end

	def sort_column
		Package.column_names.include?(params[:sort]) ? params[:sort] : "itinerary_name"
	end

	def sort_direction
		%w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
	end

	def sort_column_city
		City.column_names.include?(params[:sort]) ? params[:sort] : "city_name"
	end

end
