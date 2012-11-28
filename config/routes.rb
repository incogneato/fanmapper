Fanmapper::Application.routes.draw do

  root to: 'bars#index'
  resources :bars, only: [:index, :create]
  # resources :games, only: [:index]
end
