Rails.application.routes.draw do
  root "sessions#new"
  get "/signin" => "sessions#new", as: :signin
  get "/signout" => "sessions#destroy", as: :signout
  post "/signin" => "sessions#create"

  resources :users
end
