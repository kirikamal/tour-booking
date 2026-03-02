Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  root "home#index"

  # Tours
  resources :tours, only: %i[index show], param: :slug

  # Booking flows
  namespace :bookings do
    resource :tour,    only: %i[new create], controller: "tours"
    resource :airport, only: %i[new create], controller: "airports"
    resource :vehicle, only: %i[new create], controller: "vehicles"
    get "confirmation/:ref", to: "/bookings#confirmation", as: :confirmation
  end

  # Content pages
  get "/gallery",  to: "gallery#index",  as: :gallery
  get  "/reviews", to: "reviews#index",  as: :reviews
  post "/reviews", to: "reviews#create", as: :reviews_create
  get "/about",    to: "pages#about",    as: :about
  get "/contact",  to: "pages#contact",  as: :contact
  post "/contact", to: "pages#contact_submit", as: :contact_submit

  get "up" => "rails/health#show", as: :rails_health_check
end
