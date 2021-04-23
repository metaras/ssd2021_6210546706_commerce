Rails.application.routes.draw do
  devise_for :admins
  # root "admins/products#index"
  root 'homes#index'

  resources :homes, only: :index

  namespace :admins do

    namespace :products do
      post 'csv_upload'
    end

    resources :products do
      member do
        delete 'delete_image_attachment'
      end
    end
    
    resources :products
    resources :categories

  end
end
