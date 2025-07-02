Rails.application.routes.draw do
  devise_for :users

  get 'wallet', to: 'wallet#index'

  root 'pages#index'
  get 'pages', to: 'pages#index'

  get 'sign_in', to: 'auth#sign_in'
  get 'register', to: 'auth#register'

end
