Rails.application.routes.draw do

  scope "(:locale)", locale: /en|vi/ do
    root "static_pages#home"

    get "sessions/new"
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
    get "/signup", to: "users#new"
    get "/carts/show"
    post "/carts/clear"
    resources :users
    resources :categories, only: %i(show index)
    resources :products, only: %i(index show)
    resources :order_details, only: %i(create update destroy)
    resources :orders, only: %i(edit update)
    resources :comments
    resources :suggestions, only: %i(new create)
    namespace :admin do
      resources :categories, except: %i(show index)
      resources :users, only: :destroy
      resources :products, except: %i(index show)
      resources :orders, only: %i(index update destroy)
      resources :suggestions, only: %i(index)
    end
  end
end
