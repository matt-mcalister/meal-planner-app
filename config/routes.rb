Rails.application.routes.draw do
  resources :recipe_cards
  resources :recipe_ingredients
  resources :pantry_items
  resources :recipes
  resources :ingredients
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
