Rails.application.routes.draw do
  
  devise_for :users
  # 順番上にあげた
  resources :users,only: [:show,:index,:edit,:update]
  resources :books

  # 直るまでコメントアウト

  root 'home#top'
  get 'home/about'
end