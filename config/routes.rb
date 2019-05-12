Rails.application.routes.draw do
  resources :products, only: %i[index]
  resource :carts, only: %i[show] do
    resources :items, only: %i[create update] #########################
    scope module: :carts do
      resource :total, only: %i[show]
      resources :items, only: %i[create update] ####################### not working
      resources :discounts, only: %i[create update]
    end
  end
end
