Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'users/registrations' }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  root to: "posts#index"

  resources :posts, except: [:show] do 
    resources :comments, only: [:new, :create, :destroy], shallow: true
    member do
      post "like", to: "posts#like"
      delete "unlike", to: "posts#unlike"
    end
  end

  resources :follows, only: [:create, :update, :destroy]
  resources :users, only: [:index, :show]

end
