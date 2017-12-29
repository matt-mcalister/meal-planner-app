class Recipe < ApplicationRecord
  has_many :recipe_ingredients
  has_many :ingredients, through: :recipe_ingredients
  has_many :recipe_cards
  has_many :users, through: :recipe_cards
  has_many :instructions


end
