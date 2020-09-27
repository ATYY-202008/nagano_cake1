class Customers::OrdersController < ApplicationController
    before_action :authenticate_customer!
    before_action :set_customer

    def new
        @order = Order.new
    end

    def confirm
        @order = Order.new
        @cart_items = current_customer.cart_items
        @order.payment_method = params[:order][:payment_method]
        @order.shipping_cost = 800
        @add = params[:order][:add].to_i
        case @add
            when 1
                @order.postal_code = @customer.postal_code
                @order.address = @customer.address
                @order.name = @customer.last_name + @customer.first_name
            when 2
                @sta = params[:order][:address_id].to_i
                @address = Address.find(@sta)
                @order.postal_code = @address.postal_code
                @order.address = @address.address
                @order.name = @address.name
            when 3
                @order.postal_code = params[:order][:new_add][:postal_code]
                @order.address = params[:order][:new_add][:address]
                @order.name = params[:order][:new_add][:name]
        end
    end
    
    def create
        if current_customer.cart_items.exists?
            @order = Order.new(order_params) 
            @order.customer_id = current_customer.id
            @order.status = "入金待ち"
            @order.save
            
        if Address.find_by(address: @order.address).nil?
            @address = Address.new
            @address.postal_code = @order.postal_code
            @address.address = @order.address
            @address.name = @order.name
            @address.customer_id = current_customer.id
            @address.save
        end

        current_customer.cart_items.each do |cart_item|
            order_detail = @order.order_details.build
            order_detail.making_status = "着手不可"
            order_detail.order_id = @order.id
            order_detail.item_id = cart_item.item_id
            order_detail.amount = cart_item.amount
            order_detail.price_tax = cart_item.item.price
            order_detail.save
            cart_item.destroy 
        end
            redirect_to customers_order_thanks_path
        else
            redirect_to customers_customer_top_path
            flash[:danger] = 'カートが空です。'
        end
    end


    def thanks
    end

    def index
        @orders = Order.where(customer_id:[current_customer.id])
    end

    def show
        @order = Order.find(params[:id])	
        if @order.customer_id != current_customer.id
            redirect_to root_path
            flash[:alert] = "アクセスに失敗しました。"
        end
    end

    private
    def set_customer
        @customer = current_customer
    end

    def order_params
        params.require(:order).permit(:custmoer_id, :postal_code, :address, :name, :shipping_cost, :total_payment, :payment_method, :status)
    end
end
