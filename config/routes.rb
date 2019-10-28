Rails.application.routes.draw do

  # Giving sign in page its own path
  devise_scope :user do
    get 'login', to: 'devise/sessions#new'
  end
  devise_for :users
  # pages/index is the home page.
  root "pages#index", to: 'pages/index'

  # Routing for listings pages
  get 'listings', to: 'listings#index', as: "listings"

  # CRUD for Listings
  get 'listings/new', to: 'listings#new'
  post 'listings/new', to: 'listings#create'

end
