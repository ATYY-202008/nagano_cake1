class Admins::ItemsController < ApplicationController

    def new
      @item = Item.new
    end

    def create
      @item = Item.new(item_params)
      if @item.save
        redirect_to admins_item_path(@item)
      else
        render:new
      end
    end

    def index
      @items = Item.all.page(params[:page]).per(10)
    end

    def show
      @item = Item.find(params[:id])
      @include_tax = @item.price*1.1
      @genre = Genre.find(@item.genre_id)
    end

    def edit
      @item = Item.find(params[:id])
    end

    def update
      if @item = Item.find(params[:id])
        redirect_to admins_item_path(@item.id)
      else
        render:edit
      end
    end

    private
    def item_params
        params.require(:item).permit(:genre_id,:name,:image_id, :introduction,:price, :is_active)
    end
end
