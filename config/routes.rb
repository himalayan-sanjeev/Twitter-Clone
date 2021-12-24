Rails.application.routes.draw do
  devise_for :users, :controllers => {registrations: 'registrations'}

  resources :tweets do
    resources :comments
  end

  resources :profiles


  resources :likes, only: [:create, :destroy]

  root 'tweets#index'

end


