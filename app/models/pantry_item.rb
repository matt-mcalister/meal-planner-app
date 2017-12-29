class PantryItem < ApplicationRecord
  belongs_to :user
  belongs_to :ingredient
  # grocery list is a boolean, default to false (assumes you have it in stock)
  # validate - if quantity is zero, it is added to grocery list.


  def quantity_and_measurement
    result = "#{self.quantity_in_stock} #{self.unit_of_measurement}"
    if self.quantity_in_stock > 1
      result += "s"
    end
    result
  end
end
