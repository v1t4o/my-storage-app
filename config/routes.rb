Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :warehouses, only: [:index, :show, :new, :create, :edit, :update] do
    post 'product_entry', on: :member
    post 'product_checkout', on: :member
  end
  resources :suppliers, only: [:index, :show, :new, :create, :edit, :update]
  resources :product_models, only: [:index, :show, :new, :create, :edit, :update]
  resources :product_bundles, only: [:index, :show, :new, :create]
  resources :categories, only: [:index, :show, :new, :create]
  get 'product_items/entry', to: 'product_items#new_entry'
  post 'product_items/entry', to: 'product_items#process_entry'

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :warehouses, only: [:index, :show, :create]
      resources :suppliers, only: [:index, :show, :create]
      resources :product_models, only: [:index, :show, :create]
    end
  end
end
