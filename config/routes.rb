Rails.application.routes.draw do
  root "photos#index"

  devise_for :users

  resources :likes
  resources :follow_requests
  resources :comments
  resources :photos

  get ":username/liked" => "users#liked", as: :liked
  get ":username" => "users#show", as: :user
end
