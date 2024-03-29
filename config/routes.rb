Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  root "welcome#index"
  devise_for :accounts, path_prefix: "auth"

  concern :can_destroy_multiple do
    collection do
      post 'destroy_multiple'
    end
  end

  resources :accounts, except: [:new, :create] do
    concerns :can_destroy_multiple
  end

  resources :contest_categories, except: [:show] do
    concerns :can_destroy_multiple
    resources :contests do
      resource :forum, only: [] do
        resources :topics, except: [:new, :edit, :update] do
          resources :comments, only: [:create, :destroy]
        end
      end
      concerns :can_destroy_multiple
      resources :pages, except: [:show]
      resources :posts
      resources :form_formations, only: [:show, :edit, :update]
      resources :products do
        concerns :can_destroy_multiple
        resources :profiles, except: [:index, :show]
        resources :results, only: [:index, :edit, :update]
      end
      resources :product_categories, except: [:show] do
        concerns :can_destroy_multiple
      end
    end
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
