Rails.application.routes.draw do
  devise_for :users

  resource :profile, only: [:show, :update]

  get 'wallet', to: 'wallet#index'
  get 'pages', to: 'pages#index'
  get 'cep/:zipcode', to: 'cep#lookup', constraints: { zipcode: /\d{8}/ }

  root 'pages#index'
end
