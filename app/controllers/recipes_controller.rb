class RecipesController < ApplicationController

  def index
    @recipes = Recipe.all
    @user = current_user
    @recipe_card = RecipeCard.new(user_id: @user.id)

    if params[:recipe_name]
      @recipes = @recipes.select {|recipe| recipe.name.downcase.include?(params[:recipe_name].downcase)}
    end
  end

  def show
    @recipe = Recipe.find(params[:id])
    @instructions = @recipe.instructions
    @recipe_ingredients = @recipe.recipe_ingredients
    @user = current_user
    @recipe_card = RecipeCard.find_or_initialize_by(recipe_id: @recipe.id, user_id: @user.id)
  end

  private
    def recipe_params
      params.require(:recipe).permit(:name, :yield, :total_cooking_time)
    end


end
