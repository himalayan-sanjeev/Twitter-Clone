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

  # resources :users do
  #   get :following, :followers
  # end

  # resources :users do
  #   member do
  #     get :following, :followers
  #   end
  # end

  resources :users do
    resources :relationships, only: [:create]    
  end

  resources :relationships, only: [:destroy]

  root 'tweets#index'

end


