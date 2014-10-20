Rails.application.routes.draw do
  root "dashboard#show"
  get "/home" => "homepage#show", as: :homepage
  get "/signin" => "sessions#new", as: :signin
  get "/signout" => "sessions#destroy", as: :signout
  post "/signin" => "sessions#create"
  get "/:followee_id/follow" => "followings#create", as: :follow
  get "/:followee_id/unfollow" => "followings#destroy", as: :unfollow
  get "/users/:user_id/favorites" => "favorites#index", as: :favorites
  get "/search/results" => "searches#show", as: :search
  get "/users/:user_id/image" => "dashboard#display_image", as: :image
  get "/rants/:rant_id/spam" => "rants#spam", as: :spam
  get "/rants/:rant_id/unspam" => "rants#unspam", as: :unspam
  get "/admin/rants" => "admin#rants"
  get "/admin/spam" => "admin#spam"
  get "/admin/users" => "admin#users"

  resources :users do
    resources :rants do
      resources :favorites, only: [:create, :destroy]
      resource :comments, only: :create
    end
    resources :followings, only: :index
  end

  resource :search, only: :new
  resource :dashboard, only: :show
end
