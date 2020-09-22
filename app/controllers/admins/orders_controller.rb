class Admins::OrdersController < ApplicationController
	def index
		@orders = Order.all.page(params[:page]).per(10)
	end
	def show
		@order = Order.find(params[:id])
		@order_details = @order.order_details
		@total_payment = @order.total_payment * 1.1
		@order_total_payment =  @order.shipping_cost + @total_payment
	end
	def update
		@order = Order.find(params[:id])
		if @order.update(order_params)
			redirect_to admins_order_path(@order), notice: "You have updated status successfully."
		else
			render :show
		end
	end

	private
	def order_params
	  params.require(:order).permit(:status)
	end
end
