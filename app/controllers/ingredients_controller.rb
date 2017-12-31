class IngredientsController < ApplicationController

  def index
    @ingredients_in_stock = current_user.ingredients_in_stock
    @grocery_list = current_user.grocery_list
    @other_ingredients = Ingredient.all.reject {|ingredient| @ingredients_in_stock.include?(ingredient) || @grocery_list.include?(ingredient)}
    @user = current_user
    @pantry_item = PantryItem.new(user_id: @user.id)
  end


  def show
    @ingredient = Ingredient.find(params[:id])
  end

end
