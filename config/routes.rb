
Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  get 'homes/index'
  
  resources :assignments do
    member do
        put "like", to: "assignments#like"
        put "unlike", to: "assignments#unlike"
    end
  end

  resources :tags
  resources :categories
  resources :comments
  
  root "assignments#index"
  resources :assignments
  get "/ideas" => "assignments#index"
  post "/create_comment_ajax" => "comments#create_comment_ajax"
  get "/comments" => "comments#index"
  get "/contributions" => "users#contributions"
  get "/more_comments/:id" => "comments#more_comments", :as => "more_comments"

  get "/search" => "assignments#search"
  get "/fresh_page_view/:id" => "comments#fresh_page_view", :as => "fresh_page_view"
  get "/liked_by/:id" => "users#liked_by" , :as => "liked_by"
  # devise_for :users
  resources :users
  devise_for :user, :path => '', :path_names => { :sign_in => "login", :sign_out => "logout", :sign_up => "register" }
#custom routes defined
  # devise_scope :user do
  #   get "/login" => "devise/sessions#new"
  # end

  # devise_scope :user do
  #   delete "/logout" => "devise/sessions#destroy"
  # end

  # devise_for :users, :skip => [:sessions]
  # as :user do
  #   get 'signin' => 'devise/sessions#new', :as => :new_user_session
  #   post 'signin' => 'devise/sessions#create', :as => :user_session
  #   delete 'signout' => 'devise/sessions#destroy', :as => :destroy_user_session
  # end
  

  # devise_scope :user do
  #   authenticated :user do
  #     root 'home#index', as: :authenticated_root
  #   end

  #   unauthenticated do
  #     root 'devise/sessions#new', as: :unauthenticated_root
  #   end
  # end


  # match ':controller(/:action(/:id))(.:format)'

  

#   devise_scope :user do
#   authenticated :user do
#     root 'home#index', as: :authenticated_root
#   end

#   unauthenticated do
#     root 'devise/sessions#new', as: :unauthenticated_root
#   end
# end



  #   devise_scope :user do
  #   get "user/login" => "devise/sessions#new"
  # end
 
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

end
