Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'pages#index'
  get 'dashboard', to: 'pages#dashboard'
  resources :projects do
    resources :bugs
  end 
end
