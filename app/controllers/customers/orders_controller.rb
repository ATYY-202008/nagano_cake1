class Customers::OrdersController < ApplicationController
    before_action :authenticate_customer!
    before_action :set_customer

    def index
        @orders = @customer.orders
    end
    
    def create
        if current_customer.cart_items.exists?
            @order = Order.new(order_params)
            @order.customer_id = current_customer.id
    
            @add = params[:order][:add].to_i
            case @add
            when 1
                @order.post_code = @customer.post_code
                @order.send_to_address = @customer.address
                @order.addressee = full_name(@customer)
            when 2
                @order.post_code = params[:order][:post_code]
                @order.send_to_address = params[:order][:send_to_address]
                @order.addressee = params[:order][:addressee]
            when 3
                @order.post_code = params[:order][:post_code]
                @order.send_to_address = params[:order][:send_to_address]
                @order.addressee = params[:order][:addressee]
            end
            @order.save

            if Address.find_by(address: @order.send_to_address).nil?
            @address = Address.new
            @address.post_code = @order.post_code
            @address.address = @order.send_to_address
            @address.addressee = @order.addressee
            @address.customer_id = current_customer.id
            @address.save
            end

        current_customer.cart_items.each do |cart_item|
            order_item = @order.order_items.build
            order_item.order_id = @order.id
            order_item.product_id = cart_item.product_id
            order_item.quantity = cart_item.quantity
            order_item.order_price = cart_item.product.price
            order_item.save
            cart_item.destroy 
        end
            render :thanks
        else
            redirect_to customer_top_path
            flash[:danger] = 'カートが空です。'
        end
    end

    def show
        @order = Order.find(params[:id])
        if @order.customer_id != current_customer.id
        redirect_back(fallback_location: root_path)
        flash[:alert] = "アクセスに失敗しました。"
        end
    end

    def new
        @order = Order.new
    end

    def confirm
        @order = Order.new
        @cart_items = current_customer.cart_items
        @order.how_to_pay = params[:order][:how_to_pay]
        @add = params[:order][:add].to_i
        case @add
        when 1
            @order.post_code = @customer.post_code
            @order.send_to_address = @customer.address
            @order.addressee = @customer.family_name + @customer.first_name
        when 2
            @sta = params[:order][:send_to_address].to_i
            @send_to_address = Address.find(@sta)
            @order.post_code = @send_to_address.post_code
            @order.send_to_address = @send_to_address.address
            @order.addressee = @send_to_address.addressee
        when 3
            @order.post_code = params[:order][:new_add][:post_code]
            @order.send_to_address = params[:order][:new_add][:address]
            @order.addressee = params[:order][:new_add][:addressee]
        end
    end

    def thanks
    end

    private
    def set_customer
        @customer = current_customer
    end

    def order_params
        params.require(:order).permit(
        :custmoer_id, :postal_code, :address, :name, :shipping_cost, :total_payment, :payment_method, :status, :created_at,
        order_items_attributes: [:order_id, :item_id, :price_tax, :amount, :making_status]
        )
    end
end
