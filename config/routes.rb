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
  get "/admin_dashboard", to: 'listings#admin_dashboard', as: "admin"
  # CRUD for Conditions
  resources :conditions

  # Routes for messaging and conversations
  resources :conversations do
    resources :messages
  end
  
end
