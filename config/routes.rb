Rails.application.routes.draw do
  devise_for :users
  # pages/index is the home page.
  root "pages#index"
  get 'pages/index'
end
