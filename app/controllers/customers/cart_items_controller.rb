class Customers::CartItemsController < ApplicationController
	def create
		@cart_item = CartItem.new
	end
end
