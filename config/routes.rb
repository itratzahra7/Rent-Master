RentMaster::Application.routes.draw do
  devise_for :companies, controllers: { registrations: "registrations", sessions: "sessions" }
  resources :industries
  resources :companies do
    collection do
      #index
      get 'featured_companies'
    end
    member do
      post 'send_email'
    end
  end
  root "companies#index"
  devise_for :admins
  # devise_for :admins, :skip => [:registrations] do
  #   get "/admin" => "devise/registrations#new", :as => :new_admin_registration
  #   post "/admin" => "devise/registrations#create", :as => :admin_registration
  # end
  devise_for :users
  
  devise_scope :companies do
   root :to => "companies#index", as: :authenticated_route
  end
  
  #devise_scope :admin do
   #root :to => "admin_panel#index", as: :authenticated_route
  #end
  

  #authenticated :admin do
   # root :to => "admin_panel#index", as: :authenticated_route
  #end
  

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
  #     resources :comments
  #     resources :sales do
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
