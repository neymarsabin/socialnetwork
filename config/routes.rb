Rails.application.routes.draw do
  devise_for :users
  root 'static#index'
  get 'about',to: 'static#about'
  get 'contact',to: 'static#contact'
end
