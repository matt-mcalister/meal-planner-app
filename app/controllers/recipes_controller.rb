class RecipesController < ApplicationController

  def index
    @recipes = Recipe.all
    @user = current_user
    @recipe_card = RecipeCard.new(user_id: @user.id)
  end

  def show
    @recipe = Recipe.find(params[:id])
    @instructions = @recipe.instructions
    @recipe_ingredients = @recipe.recipe_ingredients
    @user = current_user
    @recipe_card = RecipeCard.find_or_initialize_by(recipe_id: @recipe.id, user_id: @user.id)
  end


end
