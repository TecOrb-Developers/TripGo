class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  after_filter :store_location
  # before_action :set_ip

  def store_location
  	return unless request.get? 
  	if (request.path != "/users/sign_in" &&
      request.path != "/users/sign_up" &&
      request.path != "/users/password/new" &&
      request.path != "/users/password/edit" &&
      request.path != "/users/confirmation" &&
      request.path != "/users/sign_out" &&
      !request.xhr?)
  		session[:previous_url] = request.fullpath 
  	end
  end

  def after_sign_in_path_for(resource)
    resource.role == "admin" ? admin_dashboard_path : resource.role == "consumer" ? session[:previous_url] : mainboard_path
  end 

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  def set_ip
    @ip_exist = Ipaddress.find_by_ip_address(request.remote_ip)
    if @ip_exist.nil?
      Ipaddress.create(ip_address: request.remote_ip)
    end  
  end
end
