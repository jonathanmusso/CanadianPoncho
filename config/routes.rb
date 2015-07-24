Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:update, :show]
  resources :vehicles
  resources :vehicle_images, only: [:update, :destroy]
  resources :registry_requests do 
    member do 
      patch 'approve' => 'registry_requests#approve'
      patch 'deny' => 'registry_requests#deny'
    end
  end

  get 'about' => 'welcome#about'
  root to: 'welcome#index'
end
