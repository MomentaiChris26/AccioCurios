Rails.application.routes.draw do
  

  devise_for :users
  # Giving sign in page its own path
  devise_scope :user do
    get 'login', to: 'devise/sessions#new'
  end
  
  # pages/index is the home page.
  root "pages#index", to: 'pages/index'

  # Routing for listings pages
  get 'listings', to: 'listings#index', as: "listings"
  # CRUD for Listings
  resources :listings do
    resources :comments
  end

  # CRUD for Conditions
  resources :conditions

  # Routes for Admin
  get "admin_user", to: 'admin_user#index', as: "admin"
  get 'admin_user/edit/:id', to: 'admin_user#edit', as: 'user'
  put 'admin_user/edit/:id', to: 'admin_user#update'
  patch 'admin_user/edit/:id', to: 'admin_user#update'
  delete 'admin_user/edit/:id', to: 'admin_user#destroy'





  
end
