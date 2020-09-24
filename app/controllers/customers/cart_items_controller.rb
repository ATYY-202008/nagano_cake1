class Customers::CartItemsController < ApplicationController


	def create
		@cart_item = current_customer.cart_items.build(cart_item_params)
		@current_item = CartItem.find_by(item_id: @cart_item.item_id,customer_id: @cart_item.customer_id )
		if @current_item.nil?
			@cart_item.save!
 			redirect_to  customers_cart_items_path
 		else
 			@current_item.amount += params[:amount].to_i
 			@current_item.update(cart_item_params)
 			redirect_to  customers_cart_items_path
 		end
	end

	def index
		@cart_items = current_customer.cart_items.all
	end

	def update
		@cart_item = CartItem.find(params[:id])
		if @cart_item.update(cart_item_params)
		  redirect_to customers_cart_items_path
		end
	end

	def destroy
		@cart_item = CartItem.find(params[:id])
		@cart_item.destroy
		redirect_to customers_cart_items_path
		if @cart_item = nil
			customers_customer_top_path
		end
	end

	def destroy_all
		@cart_items =CartItem.all
		@cart_items.destroy_all
		redirect_to customers_cart_items_path
	end


	private

    def cart_item_params
      params.require(:cart_item).permit(:item_id, :customer_id, :amount)
    end

    def set_customer
    	@customer = current_customer
    end

end
