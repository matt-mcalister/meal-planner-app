class RecipeIngredient < ApplicationRecord
  belongs_to :ingredient
  belongs_to :recipe

  def quantity_and_measurement
      "#{self.quantity_used} #{self.unit_of_measurement}"
  end
end
