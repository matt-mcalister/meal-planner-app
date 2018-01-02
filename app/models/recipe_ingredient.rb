class RecipeIngredient < ApplicationRecord
  belongs_to :ingredient
  belongs_to :recipe

  def quantity_with_measurement
    result = "#{self.quantity_used} #{self.unit_of_measurement}"
    if self.quantity_used > 1
      result += "s"
    end
    result
  end

  def self.units_of_measurement
    self.all.map {|recipe_card| recipe_card.unit_of_measurement}.uniq
  end
end
