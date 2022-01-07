Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :warehouses, only: [:show, :new, :create, :edit, :update]
  resources :suppliers, only: [:index, :show, :new, :create, :edit, :update]
  resources :product_models, only: [:index, :show, :new, :create, :edit, :update]
  resources :product_bundles, only: [:index, :show, :new, :create]
  resources :categories, only: [:index, :show, :new, :create]
  get 'product_items/entry', to: 'product_items#new_entry'
  post 'product_items/entry', to: 'product_items#process_entry'
end
