Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:update]
  resources :vehicles
  resources :vehicle_images
  
  get 'about' => 'welcome#about'
  root to: 'welcome#index'
end
