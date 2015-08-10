Rails.application.routes.draw do
  get 'class_participants/:id', to: 'class_participants#show', as: :class_participant
  get 'class_participants' => 'class_participants#last'
  get 'class_participants/last' => 'class_participants#last'

  get 'weekly_time_blocks' => 'weekly_time_blocks#index'
  post 'weekly_time_blocks' => 'weekly_time_blocks#create'
  get 'weekly_time_blocks/:id' => 'weekly_time_blocks#show'
  delete 'weekly_time_blocks/:id' => 'weekly_time_blocks#destroy'
  put 'weekly_time_blocks/update'
  patch 'weekly_time_blocks/update'

  get 'usual_suspects/readme'

  devise_for :users
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  #root 'usual_suspects#readme'
  root 'class_participants#last'

  # devise will redirect to this path on sign-in:
  #

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
