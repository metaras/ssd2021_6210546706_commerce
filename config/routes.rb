Rails.application.routes.draw do
  devise_for :admins
  root "products#index"

  namespace :products do
    post 'csv_upload'
  end
  
  resources :products
  resources :categories
end
