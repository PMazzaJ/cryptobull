Rails.application.routes.draw do
  resource :session
  resources :passwords, param: :token
  get 'wallet', to: 'wallet#index'
end
