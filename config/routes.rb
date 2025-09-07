Rails.application.routes.draw do
  get "home/index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Root: new fn redirects to login if not logged in, otherwise to dashboard
  root "sessions#new"

  # Bug: /login goes to login page even if logged in. or leave it as is and use login as intro page
  get "login", to: "home#index"
  get "dashboard", to: "dashboard#show"

  # Auth routes
  get "/auth/:provider/callback", to: "sessions#create"
  get "/auth/failure", to: "sessions#failure"
  delete "/logout", to: "sessions#destroy"

  # Dashboard route
  # get "/dashboard", to: "dashboard#show"
end
