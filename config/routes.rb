Rails.application.routes.draw do
  # Defines the root path route ("/")
  # root "posts#index"

  get "healthcheck" => "rails/health#show", as: :rails_health_check
  get "search" => "search#search", as: :searches
end
