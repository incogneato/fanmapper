Fanmapper::Application.routes.draw do

  root to: 'bars#index'
  resources :bars, only: [:index, :create, :show, :update] do
    resources :games, only: [:index]
  end
  # resources :games, only: [:index]
end
