Rails.application.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
  get "up" => "rails/health#show", as: :rails_health_check


  resources :posts
  # Defines the root path route ("/")
  # root "posts#index"
end
