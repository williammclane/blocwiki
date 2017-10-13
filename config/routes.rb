Rails.application.routes.draw do

  devise_for :users
  
  resources :wikis 
  
  resources :wikis do
    resources :collaborators, only: [:new, :create, :destroy]
  end

  resources :charges, only: [:new, :create] 
  
  resources :downgrade, only: [:create]
  
  authenticated :user do 
    root 'wikis#index', as: :authenticated_root 
  end 
  
  get 'about' => 'welcome#about' 
  
  root 'welcome#index' 

end
