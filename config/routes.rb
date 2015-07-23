Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:update, :show]
  resources :vehicles
  resources :vehicle_images, only: [:update, :destroy]
  
  get 'about' => 'welcome#about'
  root to: 'welcome#index'
end
