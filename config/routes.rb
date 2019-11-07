Rails.application.routes.draw do
  
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'}


  # devise_for :users, controllers: {sessions: 'users/sessions'}  
  # Giving sign in page its own path
  devise_scope :user do
    get 'login', to: 'devise/sessions#new'
  end
  
  # pages/index is the home page.
  root "pages#index", to: 'pages/index'


  # CRUD for Listings
  resources :listings do
    resources :comments
  end



  # CRUD for Conditions
  resources :conditions

  # CRUD for Categories
  resources :categories, only: [:create, :edit, :update, :show, :destroy]

  # Routes for Admin
  get "admin_user", to: 'admin_user#index', as: "admin"
  get 'admin_user/edit/:id', to: 'admin_user#edit', as: "user_edit"
  put 'admin_user/edit/:id', to: 'admin_user#update'
  patch 'admin_user/edit/:id', to: 'admin_user#update'
  delete 'admin_user/edit/:id', to: 'admin_user#destroy'

  
  get 'user_dashboard', to: 'pages#user_dashboard', as: 'user'

  # Routes for stripe payment
  get "/payments/success", to: "payments#success"
  post "/payments/webhook", to: "payments#webhook"



  
end
