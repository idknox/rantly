Rails.application.routes.draw do
  root "dashboard#show"
  get "/home" => "homepage#show", as: :homepage
  get "/signin" => "sessions#new", as: :signin
  get "/signout" => "sessions#destroy", as: :signout
  post "/signin" => "sessions#create"
  get "/:followee_id/follow" => "followings#create", as: :follow
  get "/:followee_id/unfollow" => "followings#destroy", as: :unfollow
  get "/:user_id/favorites" => "favorites#index", as: :favorites
  get "/search/results" => "search#show", as: :search

  resources :users do
    resources :rants do
      resources :favorites, only: [:create, :destroy]
    end
    resources :followings, only: :index
  end

  resource :search, only: :new
  resource :dashboard, only: :show
end
