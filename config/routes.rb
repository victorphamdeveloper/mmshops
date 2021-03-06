Mmshops::Application.routes.draw do
  resources :flags


  match '/checkout', to: "carts#checkout", via: :delete, as: :checkout
  match '/manage_seller', to: "users#manage_seller", via: :get, as: :manage_seller
  match '/ban/:id', to: "users#ban", via: :put, as: :ban
  match '/upgrade/:id', to: "users#upgrade", via: :put, as: :upgrade
  match '/product_ban/:id', to: "products#ban", via: :put, as: :product_ban
  match '/ban_products', to: "products#view_ban_products", via: :get, as: :view_ban_products
  match '/search', to: "products#search", via: :get, as: :search
  resources :carts


  resources :likes


  resources :conversations


  resources :messages, :only => [:index, :new, :create, :destroy, :show]

  resources :liked_items


  resources :orders


  resources :line_items


  resources :categories


  resources :products


  resources :seller_infos


  resources :users

  resources :sessions, only: [:new, :create, :destroy]

  match '/signup', to: "users#new"
  match '/signin', to: "sessions#new"
  match '/signout', to: "sessions#destroy", via: :delete
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
   root :to => 'products#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
