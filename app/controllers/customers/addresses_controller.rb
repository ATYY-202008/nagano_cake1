class Customers::AddressesController < ApplicationController

	def index
		@addresses = Address.all
		@address = Address.new
	end

	def create
		@address = Address.new(address_params)
		if @address.save
			redirect_to customers_addresses_path, notice: "You have creatad address successfully."
		else
			@addresses = Address.all
			render 'index'
		end
	end

	def edit
		@address = Address.find(params[:id])
	end

	def update
		@address = Address.find(params[:id])
		if @address.update(address_params)
			redirect_to customers_addresses_path, notice: "Address was successfully edited."
		else
			render 'edit'
		end
	end

	def destroy
		address = Address.find(params[:id])
		address.destroy
		redirect_to customers_addresses_path
	end

	private
	def address_params
		params.require(:address).permit(:name, :postal_code, :address, :customer_id)
	end
end
