Rails.application.routes.draw do
  get 'users/index'
  get 'users/show'
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  root to: "posts#index"

  resources :posts do 
    member do
      post "like", to: "posts#like"
      delete "unlike", to: "posts#unlike"
    end
  end

  resources :users, :only =>[:index, :show] do
    member do
      post "follow", to: "users#follow_request"
      patch "follow", to: "users#accept_request"
    end
  end
  resources :likes, :only =>[:new, :create, :destroy]
end
