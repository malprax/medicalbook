Rails.application.routes.draw do
  resources :admins
  resources :therapists
  resources :patients
  devise_for :users
  get 'pages/index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    root 'pages#index'
end
