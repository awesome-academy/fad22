Rails.application.routes.draw do

  scope "(:locale)", locale: /en|vi/ do
      root "static_pages#home"

      get "sessions/new"
      get "/login", to: "sessions#new"
      post "/login", to: "sessions#create"
      delete "/logout", to: "sessions#destroy"
      get "/signup", to: "users#new"
      get "/carts/show"
      resources :users
      resources :categories, only: %i(show index)
      resources :products, only: %i(index show)
      resources :order_details, only: %i(create update destroy)
      resources :orders, only: %i(edit update)
      namespace :admin do
        resources :categories, except: %i(show index)
        resources :users, only: :destroy
      end
  end
end
