Rails.application.routes.draw do
  devise_for :users
  root 'static#index'
  get 'about',to: 'static#about'
  get 'contact',to: 'static#contact'
  resources :posts, only: [:new,:create,:show,:destroy]
end
