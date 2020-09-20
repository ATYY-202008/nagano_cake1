class Admins::AdminsController < ApplicationController
	def top
		@orders_count = Order.where(created_at: 1.day.ago.in_time_zone("Tokyo").all_day).count
	end
end
