class Customers::HomesController < ApplicationController
	before_action :authenticate_customer!
	def top
		@genres = Genre.where(is_active: true)
		if OrderDetail.exists?(id: 1)
		 	@items = Item.find(OrderDetail.group(:item_id).order('count(item_id) desc').limit(4).pluck(:item_id))
		else
			@items = Item.where(is_active: true).limit(4)
		end
	end
	def about
		
	end
end
