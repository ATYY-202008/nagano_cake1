class Admins::OrdersController < ApplicationController
	def index
		@orders = Order.all.page(params[:page]).per(10)
	end
	def show
		@order = Order.find(params[:id])
		@order_details = @order.order_details
		order_detail = OrderDetail.find(params[:id])
		@add_price_tax = order_detail.price_tax * 1.1
		@order_price = @add_price_tax * order_detail.amount
		@total_payment = @order.total_payment * 1.1
		@order_total_payment =  @order.shipping_cost + @total_payment
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
