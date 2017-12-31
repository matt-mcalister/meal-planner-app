class User < ApplicationRecord
  has_many :recipe_cards
  has_many :recipes, through: :recipe_cards
  has_many :pantry_items
  has_many :ingredients, through: :pantry_items
  has_secure_password



  def ingredients_in_stock
    result = self.ingredients.select {|ingredient| ingredient.to_pantry_item(self.id).in_stock}
    result ||= []
  end

  def ingredients_out_of_stock
    result = self.ingredients.reject {|ingredient| ingredient.to_pantry_item(self.id).in_stock}
    result ||= []
  end

  def recipes_to_be_cooked # returns array of recipes to be cooked by user. uses "to_be_cooked" boolean attribute on recipecards
    result = self.recipes.select {|recipe| recipe.to_recipe_card(self.id).to_be_cooked}
    result ||= {}
  end

  def ingredients_needed_for_recipes_to_be_cooked
    result = self.recipes_to_be_cooked.map {|recipe| recipe.ingredients}.flatten.uniq
    result ||= []
  end

  def grocery_list # returns array of ingredients to pick up. includes ingredients from "to_be_cooked" not in pantry, as well as ingredients in pantry marked as "out of stock"
    # uses "to_be_cooked" to parse through recipes on deck. cross references each recipe's ingredients and amounts with pantry's ingredients and amounts
    result = (self.ingredients_needed_for_recipes_to_be_cooked - self.ingredients_in_stock) | self.ingredients_out_of_stock
    result ||= []
  end

  def cookable?(recipe) #cross references recipe's list of ingredients with user's pantry items
    recipe.ingredients.all? {|ingredient| self.ingredients.include?(ingredient)}
  end
end
