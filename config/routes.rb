Attend::Application.routes.draw do
  authenticate :user do
    # TODO: enforce particular users for admin access
    namespace :admin do
      resources :workspaces do
        resources :people
        resources :event_types do
          resources :events
        end
      end
      root to: 'home#index'
    end

    # API
    namespace :api do
      resources :workspaces do
        resources :people
        resources :event_types do
          resources :events
        end
      end
    end
  end

  ### Sample routes
  # /admin/workspaces # admin
  # /api/workspaces   # api
  # /workspaces/1     # web
  

  devise_for :users, controllers: {
    registrations:      'users/registrations' # custom build_resource for new users
  }

  devise_scope :user do
    # TODO: Better routes?
    match '/users/:id/complete_invitation/:invitation_token',
      :to => 'users/registrations#complete_invitation', :via => :get,
      :as => :complete_invitation

    match '/users/:id/complete_invitation_update',
      :to => 'users/registrations#complete_invitation_update', :via => :put,
      :as => :complete_invitation_update
  end


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
  root :to => 'home#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
