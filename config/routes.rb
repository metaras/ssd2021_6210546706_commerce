Rails.application.routes.draw do
  devise_for :admins
  root "products#index"
  resources :products
end
