Rails.application.routes.draw do
  devise_for :users

  resource :profile, only: [:show, :update]

  get 'wallet', to: 'wallet#index'
  get 'pages', to: 'pages#index'

  root 'pages#index'
end
