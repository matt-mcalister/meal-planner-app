class RecipeCardsController < ApplicationController

  def index
    @recipes = Recipe.all.select {|recipe| recipe.user_ids.include?(current_user.id)}
  end

  def create
    @recipe_card = RecipeCard.new(recipe_card_params)

    if @recipe_card.valid?
      @recipe_card.save
    else
      flash[:error] = @recipe_card.errors.full_messages
    end
    redirect_to recipe_path(params[:recipe_card][:recipe_id])
  end

  def update
    @recipe_card = RecipeCard.find(params[:id])

    if !@recipe_card.update(recipe_card_params)
      flash[:error] = @recipe_card.errors.full_messages
    end
    if params[:source] == "user_path(current_user)"
      redirect_to user_path(current_user)
    else
      redirect_to recipe_path(params[:recipe_card][:recipe_id])
    end
  end

  def destroy
    @recipe_card = RecipeCard.find_by(recipe_id: recipe_card_params[:recipe_id], user_id: recipe_card_params[:user_id])

  end

  private

  def recipe_card_params
    params.require(:recipe_card).permit(:recipe_id, :user_id, :favorite, :to_be_cooked)
  end
end
