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
  post 'listings', to: 'listings#create'
  get 'listings/new', to: 'listings#new', as: "new_listing"
  get "/listings/:id", to: "listings#show", as: "listing"
  put "/listings/:id", to: "listings#update"
  patch "/listings/:id", to: "listings#update"
  delete "/listings/:id", to: "listings#destroy"
  get "/listings/:id/edit", to: "listings#edit", as: "edit_listing"
  

end
