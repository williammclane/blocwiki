Rails.application.routes.draw do
  resources :wikis

  devise_for :users
  

  authenticated :user do
    root 'wikis#index', as: :authenticated_root
  end
  
  get 'about' => 'welcome#about'

  root 'welcome#index'
end
