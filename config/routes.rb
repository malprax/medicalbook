Rails.application.routes.draw do
  resources :therapists
  resources :patients
  devise_for :users, :controllers => {
    :omniauth_callbacks => "users/omniauth_callbacks",
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    confirmations: 'users/confirmations'
  }


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    root 'pages#index'
end
