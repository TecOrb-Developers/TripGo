class CrmsController < ApplicationController
	before_action :authenticate_user!

	$per_page = 15
	def index
		# ids = current_user.my_packages_ids
		# @crms = Crm.where(:package_id => ids).order("name asc").paginate(:page => 1, :per_page => $per_page)
		@crms = current_user.my_crms.order("name asc").paginate(:page => 1, :per_page => $per_page)
	end

	def crms_filter(message = nil)
		filter_against = params[:filter_against]
		filter_query = params[:filter_query]
		page = params[:page]

		crms = Crm.search(current_user.my_packages_ids, filter_query, filter_against).paginate(:page => page, :per_page => $per_page)
		respond_to do |format|
			format.js{ render "crms_filter", :locals => {:crms => crms, :message=> message} }
		end
	end

	def mark_as
		mark_as= params[:mark_as]
		ids= params[:crms_ids]
		Crm.update_status(ids, mark_as)
		crms_filter("Status Updated.") and return
	end

	def export_csv
		ids = params[:crms_ids]
		@crms = Crm.all_by_ids(ids)
		respond_to do |format|
			format.csv { send_data @crms.to_csv }
		end
	end

	def delete_selected
		ids = params[:crms_ids]
		Crm.delete_by_ids(ids)
		crms_filter("Selected Records are deleted.") and return
	end

	def csv_as_email
		email = params[:email]
		params[:crms_ids] ||= []
		result = false
		Crm.create_and_sent_as_attach(params[:crms_ids], email)
		render json: true
	end

	def status_update
		id = []
		id << params[:id]
		status = params[:status]
		Crm.update_status(id, status)
		render json: true
	end

	def assign
		@crm = Crm.find_by_id(params[:crm_id])
		@crm.update_attributes(:assigned_to => params[:email]) 
		render :json => true
	end

	private
	def export_to collection
	  respond_to do |format|
		# format.html
		format.csv { send_data collection.to_csv }
		end
	end

end
