Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check


  resources :spaces, only: [] do
    resources :entries, only: [ :index ]
    resource :sync, only: [ :create ]
    resource :full_sync, only: [ :create ]
  end
end
