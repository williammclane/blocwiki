Rails.application.routes.draw do

  devise_for :users
  
  resources :wikis 

  resources :charges, only: [:new, :create] 
  
  resources :downgrade, only: [:create]
  
  get 'about' => 'welcome#about'

  root 'welcome#index'
  
  authenticated :user do 
    root 'wikis#index', as: :authenticated_root 
  end 
end
