Rails.application.routes.draw do
  devise_for :users

  resources :favorites, only: %i[index]
  resources :lists, only: %i[index show new]

  root to: 'lists#index'
end
