class Admins::OrdersController < ApplicationController
	def index
		@orders = Order.all.page(params[:page]).per(10)
	end
	def show
		@order = Order.find(params[:id])
		@order_details = @order.order_details
	end
	def update
		@order = Order.find(params[:id])
		@order.update(order_params)
		redirect_to admins_order_path(@order)
	end

	private
	def order_params
	  params.require(:order).permit(:status)
	end
end
