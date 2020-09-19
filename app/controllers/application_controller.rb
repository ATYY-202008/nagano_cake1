class ApplicationController < ActionController::Base

  def after_sign_in_path_for(resource)
  	flash[:notice] = "Welcome! You have signed up successfully."
  	case resource
  	when Customer
  		customers_items_path
  	when Admin
  		admins_items_path
  	end
  end

  def after_sign_out_path_for(resource)
  	flash[:notice]= "Signed out successfully."
  	root_path
  end
end
