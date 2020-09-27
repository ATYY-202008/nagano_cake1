class Admins::AdminsController < ApplicationController
	def top
		@orders = Order.all
		@orders_count = @orders.where(created_at: (Time.now.midnight - 1.day)..Time.now.midnight).count
	end
end
