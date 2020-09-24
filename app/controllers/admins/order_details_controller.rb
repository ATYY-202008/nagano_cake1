class Admins::OrderDetailsController < ApplicationController
	def update
		@order_detail = OrderDetail.find(params[:id])
		@order = @order_detail.order
		if @order_detail.update(order_detail_params)
			redirect_to admins_order_path(@order_detail.order_id), notice: "You have updated making_status successfully."
		else
			render template: 'orders/show'
		end

		# 自動更新機能 
		if @order_detail.making_status == "製作中" 
			@order.update(status: "製作中") 
		 end 
		# 自動更新機能 

	end

	private
	def order_detail_params
	  params.require(:order_detail).permit(:making_status)
	end
end
