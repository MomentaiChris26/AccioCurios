Rails.application.routes.draw do

  # Giving sign in page its own path
  devise_scope :user do
    get 'login', to: 'devise/sessions#new'
  end
  devise_for :users
  # pages/index is the home page.
  root "pages#index"
  get 'pages/index'


end
