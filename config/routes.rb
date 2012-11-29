Fanmapper::Application.routes.draw do

  root to: 'home#index'
  resources :bars
  resources :teams, only: [:show]

end
