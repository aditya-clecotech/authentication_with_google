Rails.application.routes.draw do

  root "home#index"
  resources :posts do 
    member do
      delete "images/:image_id", to: "posts#destroy_image", as: :image
    end 
  end 
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

end
