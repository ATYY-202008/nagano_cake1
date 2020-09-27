Rails.application.routes.draw do
  namespace :admins do
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  #rootパス
  root 'customers/homes#top'

  # 管理者用サイトのrouting
   devise_for :admins
   namespace :admins do
    get 'top' => 'admins#top', as:'top'
	    resources :customers, only: [:index, :edit, :show, :update, :unsubscribe]
	    resources :items, except: [:destroy]
	    resources :orders, only: [:index, :show, :update]
	    resources :order_details, only: [:update]
	    resources :genres, only: [:index, :create, :edit, :update]
		get 'search' => 'searches#search'
	end

	# 顧客用サイトのrouting
    devise_for :customers
    namespace :customers do
	    get 'homes/top' => 'homes#top', as: 'customer_top'
		get 'homes/about' => 'homes#about', as: 'customer_about'
		resource :customers, only: [:show,:edit, :update]
		get 'customers/unsubscribe' => 'customers#unsubscribe', as: 'customer_unsubscribe'
		patch 'customers/withdraw' => 'customers#withdraw', as: 'customer_withdraw'
		get 'orders/thanks' => 'orders#thanks', as: 'order_thanks'
		resources :orders, only: [:new, :index, :create, :show]
		  post 'orders/confirm' => 'orders#confirm', as: 'order_confirm'
		  
		resources :items, only: [:index, :show]
		resources :addresses, only: [:index, :create, :edit, :update, :destroy]

		#カートアイテムを全て削除メソッドのために追加
		resources :cart_items, only: [:index, :create, :update, :destroy] do
		    collection do
		        delete 'destroy_all'
		    end
		end
	end
end
