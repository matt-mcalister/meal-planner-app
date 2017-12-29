class Ingredient < ApplicationRecord
  has_many :recipe_ingredients
  has_many :recipes, through: :recipe_ingredients
  has_many :pantry_items
  has_many :users, through: :pantry_items

  def units_of_measurement
    self.recipe_ingredients.map {|r_i| r_i.unit_of_measurement}.uniq
  end

end
