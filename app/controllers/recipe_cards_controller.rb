class RecipeCardsController < ApplicationController

  def index
    @recipes = Recipe.all.select {|recipe| recipe.user_ids.include?(current_user.id)}
  end
end
