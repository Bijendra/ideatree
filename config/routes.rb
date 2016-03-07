Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  get 'homes/index'

  resources :tags
  resources :categories
  resources :comments
  devise_for :users
  resources :users
  root "assignments#index"
  resources :assignments
  get "/ideas" => "assignments#index"
  post "/create_comment_ajax" => "comments#create_comment_ajax"
  get "/comments" => "comments#index"

  # match ':controller(/:action(/:id))(.:format)'
end
