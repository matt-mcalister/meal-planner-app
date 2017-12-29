class RecipesController < ApplicationController

  def index
    @recipes = Recipe.all
    @user = current_user
  end

  def show
    @recipe = Recipe.find(params[:id])
    @instructions = @recipe.instructions
    @recipe_ingredients = @recipe.recipe_ingredients
    @user = current_user
  end


end
