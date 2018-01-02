class IngredientsController < ApplicationController

  def index
    @ingredients_in_stock = current_user.ingredients_in_stock
    @grocery_list = current_user.grocery_list
    @other_ingredients = Ingredient.all.reject {|ingredient| @ingredients_in_stock.include?(ingredient) || @grocery_list.include?(ingredient)}
    @user = current_user
    @pantry_item = PantryItem.new(user_id: @user.id)

    if params[:ingredient_name]
      @ingredients_in_stock = @ingredients_in_stock.select {|ingredient| ingredient.name.downcase.include?(params[:ingredient_name].downcase)}
      @grocery_list = @grocery_list.select {|ingredient| ingredient.name.downcase.include?(params[:ingredient_name].downcase)}
      @other_ingredients = @other_ingredients.select {|ingredient| ingredient.name.downcase.include?(params[:ingredient_name].downcase)}
    end

  end


  def show
    @ingredient = Ingredient.find(params[:id])
  end

end
