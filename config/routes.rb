Rails.application.routes.draw do

  resources :carts do
    collection do
      delete :clean
      post :checkout
    end
  end

  namespace :admin do
    resources :products
    resources :categories
     resources :orders do
       member do
         post :cancel
         post :ship
         post :shipped
         post :return
       end
     end
  end

  devise_for :users

  root 'products#index'

  resources :products do
    collection do
      get :search
    end    
    member do
      post :add_to_cart
    end
  end

  resources :cart_items

  resources :orders do
    member do
      post :pay_with_alipay
      post :pay_with_wechat
      post :apply_to_cancel
    end
  end

  namespace :account do
    resources :orders
  end

end
