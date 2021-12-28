Rails.application.routes.draw do
  devise_for :users, :controllers => {registrations: 'registrations'}

  resources :tweets do
    resources :comments do
      post 'hide', on: :member
    end
  end

  resources :users

  resources :tweets do
    resources :likes
  end
  # resources :likes, only: [:create, :destroy]

  root 'tweets#index'

end


