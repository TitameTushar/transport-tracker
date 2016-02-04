Project::Application.routes.draw do
  match 'routes/:route_id/display' => 'halts#display', via: :get, as: :display_route_halts
  match 'routes/:route_id/halts/:id/register' => 'halts#register', via: [:get,:post], as: :register_route_halt
  match 'routes/:route_id/halts/:id/remove' => 'halts#remove', via: [:get,:post], as: :remove_route_halt
  match 'routes/:route_id/buses/:bus_id/assign' => 'buses#assign', via: [:get,:post], as: :assign_bus
  match 'routes/:route_id/halts/:id/assign_halt' => 'halts#assign_halt', via: [:get,:post], as: :assign_halt_route_halt
  match 'users/:id/menu' => 'users#menu', via: :get, as: :menu_user
  match 'buses/:bus_id/users/drivers' => 'users#drivers', via: :get, as: :drivers_bus_user
  match 'users/:user_id/buses/:bus_id/assign_driver' => 'users#assign_driver', via: :get, as: :assign_driver_bus_user
  match 'users/alert' => 'users#alert', via: :get, as: :alert_user
  resources :positions, only: [:edit, :update, :show, :destroy]
  resources :buses
  resources :halts
  resources :users do
     resources :positions, only: [:show]
    resources :buses
  end
  resources :routes do
    resources :buses
    resources :halts do 
      resources :buses
    end
  end
  resources :sessions, only: [:new, :create, :destroy]
  root  'static_pages#home'
  match '/signup',  to: 'users#new',            via: 'get'
  match '/signin',  to: 'sessions#new',         via: 'get'
  match '/signout', to: 'sessions#destroy',     via: 'delete'
  match '/help',    to: 'static_pages#help',    via: 'get'
  match '/about',   to: 'static_pages#about',   via: 'get'
  match '/contact', to: 'static_pages#contact', via: 'get'

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
