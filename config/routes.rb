Rails.application.routes.draw do
  # Full CRUD
  resources :users #, only: [:show, :new, :create, :edit, :update, :delete]
  resources :recipe_cards
  resources :pantry_items

  # Just Read
  resources :recipes, only: [:index, :show]
  resources :ingredients, only: [:index, :show]

  # Sessions
  get "/signup", to: "users#new", as: "signup"
  get "/signin", to: "sessions#new"
  post "/sessions", to: "sessions#create"
  delete "/sessions", to: "sessions#destroy"
  root to: "static#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
