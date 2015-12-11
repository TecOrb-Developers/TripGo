class UsersController < ApplicationController
	before_action :authenticate_user! , except: [:suplier_sign_up,:create_supplier_account,:create_consumer_account,:check_email,:supplier_detail,:more_packages,:approve_user,:users_send_mail_by_admin,:approve_partner]
	include Sidekiq::Worker 

	def suplier_sign_up
		@user = User.new
		@profile = @user.build_profile
	end

	def create_supplier_account
		@user = User.new(user_params)
		@user.role = 'supplier'
		if @user.save
			sign_in @user
			redirect_to mainboard_path, :notice => "Thanks for signing up!"
		else
			render :suplier_sign_up
		end
	end

	def edit_suplier
		authorize! :edit_supplier, current_user
		@user = User.find(params[:id])
		@user.profile
	end

	def update_supplier_account
		current_user.update_attributes(user_params)
		redirect_to menu_board_path, :notice => "Successfully updated!"
	end

	def update_password
		@user = User.find(current_user.id)
		if @user.update_with_password(user_params)
      # Sign in the user by passing validation in case their password changed
      sign_in @user, :bypass => true
      redirect_to root_path,:notice => "Successfully done"
    else
    	redirect_to root_url, :alert => "Old password is not valid"
    end
  end

  def check_email
  	render :json => User.exists?(:email => params[:email])
  end

  def create_consumer_account
  	@user = User.new(user_params)
  	@user.role = 'consumer'
  	if @user.save
  		sign_in @user
  		redirect_to :back, :notice => "Thanks for signing up!" and return
  	else
  		flash[:alert] = "Error while signing up."
  	end
  	redirect_to :back
  end

  def supplier_detail
  	@supplier = User.find(params[:id])
  	@supplier_profile = @supplier.profile
		#Destination types
		@beaches_packages = @supplier.packages.select{|x| x.holidays.include?('Beaches')}.paginate(:page => 1, :per_page => 1)
		@deserts_packages = @supplier.packages.select{|x| x.holidays.include?('Deserts')}.paginate(:page => 1, :per_page => 1)
		@hills_valleys_packages = @supplier.packages.select{|x| x.holidays.include?('Hills and Valleys')}.paginate(:page => 1, :per_page => 1)
		@river_lakes_packages = @supplier.packages.select{|x| x.holidays.include?('Rivers and Lakes')}.paginate(:page => 1, :per_page => 1)
		@wildlife_packages = @supplier.packages.select{|x| x.holidays.include?('Wildlife')}.paginate(:page => 1, :per_page => 1)
		@religiouse_packages = @supplier.packages.select{|x| x.holidays.include?('Religious')}.paginate(:page => 1, :per_page => 1)
		@heritage_packages = @supplier.packages.select{|x| x.holidays.include?('Heritage')}.paginate(:page => 1, :per_page => 1)
		#Holidays types
		@romantic_packages = @supplier.packages.select{|x| x.holiday_types.include?('Romantic')}.paginate(:page => 1, :per_page => 1)
		@spa_wellness_packages = @supplier.packages.select{|x| x.holiday_types.include?('Spa and Wellness')}.paginate(:page => 1, :per_page => 1)
		@family_packages = @supplier.packages.select{|x| x.holiday_types.include?('Family')}.paginate(:page => 1, :per_page => 1)
		@budget_packages = @supplier.packages.select{|x| x.holiday_types.include?('Budget')}.paginate(:page => 1, :per_page => 1)
		@adventure_packages = @supplier.packages.select{|x| x.holiday_types.include?('Adventure')}.paginate(:page => 1, :per_page => 1)
		@luxury_packages = @supplier.packages.select{|x| x.holiday_types.include?('Luxury')}.paginate(:page => 1, :per_page => 1)
		@food_drinks_packages = @supplier.packages.select{|x| x.holiday_types.include?('Food and Drinks')}.paginate(:page => 1, :per_page => 1)
		@sports_packages = @supplier.packages.select{|x| x.holiday_types.include?('Sports')}.paginate(:page => 1, :per_page => 1)	
		@friends_packages = @supplier.packages.select{|x| x.holiday_types.include?('Friends')}.paginate(:page => 1, :per_page => 1)
	end

	def more_packages
		@supplier = User.find(params[:id])
		if params[:type] == 'destination'
			@more_packages = @supplier.packages.select{|x| x.holidays.include?(params[:category])}.paginate(:page => params[:page], :per_page => 1)
		else
			@more_packages = @supplier.packages.select{|x| x.holiday_types.include?(params[:category])}.paginate(:page => params[:page], :per_page => 1)	
		end
		respond_to do |format|
			format.js
		end
	end

# ActveAdmin actions
	def approve_user	
		user = User.find(params[:id])
		user.update_attributes(:approved => !user.approved)
		# notification need to test
		action_type = user.approved? ? 'PROFILE_APPROVED' : 'PROFILE_DISAPPROVED' 
		# Notification.create_notification(current_admin_user.id, user.id, action_type, user) if current_admin_user != user
		redirect_to admin_users_path
	end

	def approve_partner	
		user = User.find(params[:id])
		user.update_attributes(:approved => !user.approved)
		action_type = user.approved? ? 'PROFILE_APPROVED' : 'PROFILE_DISAPPROVED' 
		redirect_to  admin_partner_list_path
	end

	def users_send_mail_by_admin
		reciever = params[:send_mail][:to] == 'All Supplier' ? 'supplier' : 'consumer'
		reciever_emails = User.where(:role => reciever).pluck(:email)
		@offer = Offer.create(:content => params[:send_mail][:offer],:send_to => reciever,:admin_user_id => current_admin_user.id)
		if @offer
			Notifier.perform_async(reciever_emails,params[:send_mail][:offer])
			flash[:notice] = "Email message has been sent to all #{reciever.titleize}s"
		else
			flash[:notice] = "Something went wrong, Please try again later."
		end
		redirect_to admin_send_email_path
	end

	private
	def user_params
		params.require(:user).permit!
	end

end
