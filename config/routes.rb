Rails.application.routes.draw do
  root "dashboard#show"
  get "/home" => "homepage#show", as: :homepage
  get "/signin" => "sessions#new", as: :signin
  get "/signout" => "sessions#destroy", as: :signout
  post "/signin" => "sessions#create"
  get "/:followee_id/follow" => "followings#create", as: :follow
  get "/:followee_id/unfollow" => "followings#destroy", as: :unfollow

  resources :users do
    resources :rants
    resources :followings, :only => :index
  end

  resource :dashboard, :only => :show
end
