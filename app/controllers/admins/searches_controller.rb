class Admins::SearchesController < ApplicationController

  def search
		@range = params[:range]
		search = params[:search]
		word = params[:word]
		@word = word

		if  @range == "1"
			@customer_search = Customer.search(search,word)
		else
			@item_search = Item.search(search,word)
		end
	end
end
