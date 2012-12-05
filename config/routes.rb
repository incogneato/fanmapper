Fanmapper::Application.routes.draw do

  devise_for :users, path_names:  { sign_in: "login", sign_out: "logout" },
                     controllers: { omniauth_callbacks: "omniauth_callbacks" }

  root to: 'home#index'
  resources :bars
  resources :teams, only: [:show]
  resources :games, only: [:index, :show]

  match "bars/:bar_id/add_game/:id" => "bars#add_game", :as => "add_game"

end
