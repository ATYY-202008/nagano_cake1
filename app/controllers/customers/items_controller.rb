class Customers::ItemsController < ApplicationController
	before_action :authenticate_customer!
	def index
		@genres = Genre.where(is_active: true)
		if params[:genre_id]
			@genre = Genre.find(params[:genre_id])
	        @items = @genre.items.page(params[:page]).per(8)
	        @item = @items.where(params[:id]).count
	    else
	    	@items = Item.joins(:genre).where(genres: {is_active: true}).page(params[:page]).per(8)
	    	@item = Item.where(params[:id]).count
	    end
	end

	def show
		@item = Item.find(params[:id])
		@genres = Genre.where(is_active: true)
		@cart = @item.cart_items.build
	end

end

