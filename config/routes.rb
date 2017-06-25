Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :questions do
    resources :answers
  end

  devise_for :users
  root 'posts#index'
  get 'about',to: 'static#about'
  get 'contact',to: 'static#contact'
  get 'profile',to: 'static#profile'
  resources :posts, only: [:new,:create,:show,:destroy,:update,:edit,:index] do
    resources :comments, except: [:show,:index]
    member do
      put "like" => "posts#upvote"
      put "dislike" => "posts#downvote"
    end
  end

  root 'conversations#index'
  resources :personal_messages, only: [:create,:new]
  resources :conversations, only: [:index,:show]
  resources :users,only: [:index,:show]
  resources :friendships
  

  get 'my_friends',to: "users#my_friends"
  post 'add_friends',to: "users#add_friends"
  
end
