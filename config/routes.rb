Rails.application.routes.draw do
  # Full CRUD
  resources :users, only: [:show, :new, :create, :edit, :update, :destroy]
  resources :recipe_cards
  resources :pantry_items, only: [:edit, :create, :update, :destroy]

  post "/grocery_list/:id", to: 'pantry_items#create_grocery', as: "new_grocery_item"

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
