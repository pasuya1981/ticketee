Rails.application.routes.draw do

  namespace :admin do
    root to: 'base#index'
    resources :users
  end

  root "projects#index"

  #match "projects", to: "projects#index", via: [:get], as: 'projects'
  #match 'projects', to: 'projects#create', via: :post
  #match "projects/new", to: "projects#new", via: :get, as: 'new_project'
  #match "projects/:id/edit", to: 'projects#edit', via: :get, as: 'edit_project'
  #match 'projects/:id', to: 'projects#show', via: :get, as: 'project'
  #match 'projects/:id', to: 'projects#update', via: [:patch, :put]
  #match 'projects/:id', to: 'projects#destroy', via: :delete

  get '/signout', to: 'sessions#destroy'
  post '/signin', to: 'sessions#create'
  get '/signin', to: 'sessions#new'
  resources :users
  resources :projects do

    resources :tickets
  end

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
