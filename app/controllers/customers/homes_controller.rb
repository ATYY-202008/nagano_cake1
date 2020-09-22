class Customers::HomesController < ApplicationController
	def top
		@genres = Genre.where(is_active: true)
	end
	def about
		
	end
end
