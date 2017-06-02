Rails.application.routes.draw do
  resources :carts do
    collection do
      delete :clean
      post :checkout
    end
  end
  namespace :admin do
    resources :products
  end

  devise_for :users
  root 'products#index'
  resources :products do
    member do
      post :add_to_cart
    end
  end

  resources :cart_items
end
