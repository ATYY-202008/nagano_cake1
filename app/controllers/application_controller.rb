class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
  	flash[:notice] = "Welcome! You have signed up successfully."
  	case resource
  	when Customer
  		customers_items_path
  	when Admin
  		admins_top_path
  	end
  end

  def after_sign_out_path_for(resource)
  	flash[:notice]= "Signed out successfully."
  	root_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number, :is_deleted])
    devise_parameter_sanitizer.permit(:account_update, keys: [:is_deleted])
  end
end
