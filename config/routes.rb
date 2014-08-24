Rails.application.routes.draw do
  root "rants#new"
  get "/home" => "homepage#show", as: :homepage
  get "/signin" => "sessions#new", as: :signin
  get "/signout" => "sessions#destroy", as: :signout
  post "/signin" => "sessions#create"


  resources :users do
    resources :rants
  end
end
