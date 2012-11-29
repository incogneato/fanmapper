Fanmapper::Application.routes.draw do

  root to: 'bars#index'
  resources :bars
  # resources :games, only: [:index]
end
