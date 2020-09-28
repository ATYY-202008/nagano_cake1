class Admins::OrderDetailsController < ApplicationController
	before_action :authenticate_admin!
	def update
		@order_detail = OrderDetail.find(params[:id])
		@order = @order_detail.order
		if @order_detail.update(order_detail_params)
			if @order_detail.making_status == "製作中" 
				@order.update(status: "製作中") 
			 end
			 making_statuses = Array.new 
			 @order.order_details.each do |order_detail| 
			 	making_statuses.push(order_detail.making_status)
			 end
			 unless making_statuses.include?("着手不可") || making_statuses.include?("製作待ち") || making_statuses.include?("製作中")
			 	@order.update(status: "発送準備中")
			 end
			redirect_to admins_order_path(@order_detail.order_id), notice: "You have updated making_status successfully."
		else
			render template: 'orders/show'
		end

	end

	private
	def order_detail_params
	  params.require(:order_detail).permit(:making_status)
	end
end
