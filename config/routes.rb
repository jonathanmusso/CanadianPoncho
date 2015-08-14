Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:update, :show]
  resources :vehicles do
    member do
      get 're_edit' => 'vehicles#re_edit'
      post 'resubmit' => 'vehicles#resubmit'
      patch 'resubmit' => 'vehicles#resubmit'
    end
  end
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
