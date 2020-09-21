class Customers::ItemsController < ApplicationController

	def index
		@genres = Genre.where(is_active: true)
		if params[:genre_id]
			@genre = Genre.find(params[:genre_id])
	        @items = @genre.items.page(params[:page]).per(8)
	        @item = @items.where(params[:id]).count
	    else
	    	@items = Item.page(params[:page]).per(8)
	    	@item = Item.where(params[:id]).count
	    end
	end

	def show
		@item = Item.find(params[:id])
		@genres = Genre.where(is_active: true)
		@cart_item = CartItem.new
	end

end

