Fanmapper::Application.routes.draw do

  root to: 'home#index'
  resources :bars, only: [:index, :new, :create]
  resources :teams, only: [:show]
  resources :games, only: [:index]
end
