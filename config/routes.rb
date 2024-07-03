Rails.application.routes.draw do
  root "photos#index"

  get "/users/:id" => "users#show", as: :user

  devise_for :users

  resources :likes
  resources :follow_requests
  resources :comments
  resources :photos
end
