Rails.application.routes.draw do
  devise_for :users

  resources :favorites, only: %i[index]
  resources :lists

  root to: 'lists#index'
end
