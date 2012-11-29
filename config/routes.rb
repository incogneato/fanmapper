Fanmapper::Application.routes.draw do

  root to: 'bars#index'
  resources :bars do
    resources :games, only: [:index]
  end
  # resources :games, only: [:index]
end
