Rails.application.routes.draw do
  use_doorkeeper

  resources :members
  get 'tasks/list', as: :lista_tareas
  # get 'tasks/lists' => 'tasks#list'
  #
  get 'tasks/nueva' => 'tasks#new', as: :nueva_tarea
  post 'tasks/crear' => 'tasks#create'

  # /tasks/214
  get 'tasks/:id' => 'tasks#show', as: :ver_tarea
  get 'tasks/:id/editar' => 'tasks#edit', as: :editar_tarea
  post 'tasks/:id/update' => 'tasks#update', as: :actualizar_tarea
  delete 'tasks/:id/delete' => 'tasks#delete', as: :eliminar_tarea
  # get 'tasks/:id/delete' => 'tasks#delete', as: :eliminar_get_tarea

  get 'holamundo' => 'application#holamundo'

  get 'login' => 'sessions#new', as: :login
  post 'login' => 'sessions#create', as: :sign_in
  delete 'logout' => 'sessions#destroy', as: :logout
  match '*path' => 'application#cors_preflight_check', via: :options




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
