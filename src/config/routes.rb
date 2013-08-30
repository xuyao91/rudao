Rudao::Application.routes.draw do 
 # mount Ckeditor::Engine => '/ckeditor'
  # get "users/new"
# 
  # get "users/edit"
# 
  # get "user_sessions/new"

  # resources :admins
# 
  # resource :admin, :only => [:new, :create, :destroy]
# 
  # match 'signup' => 'admins#new', :as => :signup
# 
  # match 'register' => 'admins#create', :as => :register
# 
  # match 'login' => 'admins#new', :as => :login
# 
  # match 'logout' => 'admins#destroy', :as => :logout
# 
  # match '/activate/:activation_code' => 'admins#activate', :as => :activate, :activation_code => nil

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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
   #match ':controller(/:action(/:id))(.:format)'
 resources :users  
  namespace :admin do
    
    resources :admins do
    end
    resources :admin_sessions
  end
  resources :user_sessions
  # match 'register' => 'admins#create', :as => :register
  #match 'users/index' => 'users#index'
 # map.login 'login', :controller => 'user_sessions', :action => 'new'
  #match 'user_session/:id' => 'catalog#view'
  # match 'login' => 'user_sessions#new', :as => :login
  # match 'logout' => 'user_sessions#destroy', :as => :logout
  # match 'admin/login' => 'admin/admin_sessions#new'#, :as => :login
  # match 'admin/logout' => 'admin/admin_sessions#destroy'
  # match ':controller(/:action(/:id))(.:format)'
end
