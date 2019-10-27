Rails.application.routes.draw do
  # pages/index is the home page.
  root "pages#index"
  get 'pages/index'
end
