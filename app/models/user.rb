class User < ApplicationRecord
  has_many :recipe_cards
  has_many :recipes, through: :recipe_cards
  has_many :pantry_items
  has_many :ingredients, through: :pantry_items
  has_secure_password
end
