class User < ApplicationRecord
  has_many :recipe_cards
  has_many :recipes, through: :recipe_cards
  has_many :pantry_items
  has_many :ingredients, through: :pantry_items
  has_secure_password

  def pantry_items_in_stock
    self.pantry_items.select {|pantry_item| pantry_item.in_stock}
  end

  def recipes_to_be_cooked # returns array of recipes to be cooked by user. uses "to_be_cooked" boolean attribute on recipecards
    self.recipe_cards.select {|recipe_card| recipe_card.to_be_cooked}.map {|recipe_card| recipe_card.recipe}
  end

  def grocery_list # returns array of ingredients to pick up.
    # uses "to_be_cooked" to parse through recipes on deck. cross references each recipe's ingredients and amounts with pantry's ingredients and amounts
    self.recipes_to_be_cooked.reject {|recipe| self.cookable?(recipe)}.map {|recipe| recipe.ingredients}.flatten.uniq
  end

  def cookable?(recipe) #cross references recipe's list of ingredients with user's pantry items
    # CURRENT VERSION CANNOT HANDLE QUANTITIES
    recipe.ingredients.all? {|ingredient| self.ingredients.include?(ingredient)}
  end
end
