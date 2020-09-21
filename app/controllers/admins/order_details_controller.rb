class Admins::OrderDetailsController < ApplicationController
	def update
		@order_detail = OrderDetail.find_by(order_id: params[:order_id], item_id: params[:item_id])
		@order_detail.update(order_detail_params)
		redirect_to admins_order_path(@order_detail)
	end

	private
	def order_detail_params
	  params.require(:order_detail).permit(:making_status)
	end
end
