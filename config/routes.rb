Rails.application.routes.draw do
  resources :vehicles
  
  get 'about' => 'welcome#about'
  root to: 'welcome#index'
end
