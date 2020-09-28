class Customers::CustomersController < ApplicationController
	before_action :authenticate_customer!
	def show
		@customer = Customer.find(current_customer.id)
	end
	def edit
		@customer = Customer.find(current_customer.id)
	end
	def update
		@customer = Customer.find(current_customer.id)
		if @customer.update(customer_params)
			redirect_to customers_customers_path, notice: "You have updated customer successfully."
		else
			render :edit
		end
	end
	def unsubscribe
		
	end
	def withdraw
		@customer = Customer.find(current_customer.id)
		if @customer.update(is_deleted: true)
			
			reset_session
			redirect_to root_path, notice: "You have withdrawn successfully."
		else
			render :unsubscribe
		end
	end

	private
	def customer_params
	  params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number, :email, :is_deleted)
	end
end
