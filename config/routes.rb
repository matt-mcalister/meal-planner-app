Rails.application.routes.draw do
  # Full CRUD
  resources :users, only: [:show, :new, :create, :edit, :update, :destroy]
  resources :recipe_cards, only: [:index, :create, :update, :destroy]
  resources :pantry_items, only: [:index, :create, :update, :destroy]


  # Just Read
  resources :recipes, only: [:index, :show]
  resources :ingredients, only: [:index, :show]

  # Sessions
  get "/signup", to: "users#new", as: "signup"
  get "/signin", to: "sessions#new"
  post "/sessions", to: "sessions#create"
  delete "/sessions", to: "sessions#destroy"
  root to: "static#index"

  post "/pantry_items/groceries", to: "pantry_items#groceries", as: "pantry_groceries"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
