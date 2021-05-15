Rails.application.routes.draw do
  devise_for :admins
  root 'homes#index'

  resources :homes, only: :index do
    match '/create_order' => 'homes#create_order', via: [:get, :post]
  end
  resources :users
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
