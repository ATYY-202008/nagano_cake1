class Customers::AddressesController < ApplicationController

	def index
		@addresses = Address.all
		@address = Address.new
	end

	def create
		@address = Address.new(address_params)
		@address.save
		redirect_to customers_addresses_path
	end

	def edit
		@address = Address.find(params[:id])
	end

	def update
		@address = Address.find(params[:id])
		@address.update(address_params)
		redirect_to customers_addresses_path
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
