class Admins::OrdersController < ApplicationController
	def index
		@orders = Order.all.page(params[:page]).per(10)
	end
	def show
		@order = Order.find(params[:id])
		@order_deatils = OrderDetail.all
	end
end
