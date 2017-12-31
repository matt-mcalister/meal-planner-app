class Recipe < ApplicationRecord
  has_many :recipe_ingredients
  has_many :ingredients, through: :recipe_ingredients
  has_many :recipe_cards
  has_many :users, through: :recipe_cards
  has_many :instructions

  def to_recipe_ingredient(ingredient_id)
    RecipeIngredient.find_by(recipe_id: self.id, ingredient_id: ingredient_id)
  end

  def to_recipe_card(user_id)
    RecipeCard.find_by(user_id: user_id, recipe_id: self.id)
  end

end
