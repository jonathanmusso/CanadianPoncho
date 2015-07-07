Rails.application.routes.draw do
  get 'welcome/about'

  root to: 'welcome#index'
end
