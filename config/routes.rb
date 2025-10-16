Rails.application.routes.draw do
  get "static/index"
  resources :salespeople
  root 'cars#index'

  resources :car_purchases, only: [:index, :show]
  resources :dealerships, only: [:index, :show]
  resources :people, only: [:index, :show]
  resources :cities, only: [:index, :show]
  resources :manufacturers, only: [:index, :show]
  resources :cars, only: [:index, :show]

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  get 'static/index', to: 'static#index'
  get '/search', to: 'cars#search'
  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
