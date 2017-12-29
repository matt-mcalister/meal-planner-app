class IngredientsController < ApplicationController

  def index
    @other_ingredients = Ingredient.all.reject {|ingredient| ingredient.user_ids.include?(current_user.id)}
    @pantry_items = current_user.pantry_items_in_stock
    @grocery_list = current_user.grocery_list
  end

  def show
    @ingredient = Ingredient.find(params[:id])
  end

end
