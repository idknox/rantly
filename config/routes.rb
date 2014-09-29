Rails.application.routes.draw do
  root "dashboard#show"
  get "/home" => "homepage#show", as: :homepage
  get "/signin" => "sessions#new", as: :signin
  get "/signout" => "sessions#destroy", as: :signout
  post "/signin" => "sessions#create"


  resources :users do
    resources :rants
    # resources :followers
  end

  resource :dashboard, :only => :show
end
