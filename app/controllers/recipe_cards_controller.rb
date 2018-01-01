class RecipeCardsController < ApplicationController

  def index
    @recipes = Recipe.all.select {|recipe| recipe.user_ids.include?(current_user.id)}
    @user = current_user
  end

  def create
    @recipe_card = RecipeCard.new(recipe_card_params)

    if @recipe_card.valid?
      @recipe_card.save
    else
      flash[:error] = @recipe_card.errors.full_messages
    end
    if params[:source] == "recipe_path(@recipe)"
      redirect_to recipe_path(@recipe_card.recipe_id)
    else
      redirect_to method(params[:source]).call
    end
  end

  def update
    @recipe_card = RecipeCard.find(params[:id])
    if !@recipe_card.update(recipe_card_params)
      flash[:error] = @recipe_card.errors.full_messages
    end
    if params[:source] == "recipe_path(@recipe)"
      redirect_to recipe_path(@recipe_card.recipe_id)
    elsif params[:source] == "user_path(current_user)"
      redirect_to user_path(current_user)
    else
      redirect_to method(params[:source]).call
    end
  end

  def destroy
    @recipe_card = RecipeCard.find(params[:id])
    @recipe = @recipe_card.recipe
    @recipe_card.destroy
    if params[:source] == "recipe_path(@recipe)"
      redirect_to recipe_path(@recipe)
    else
      redirect_to method(params[:source]).call
    end
  end

  private

  def recipe_card_params
    params.require(:recipe_card).permit(:recipe_id, :user_id, :favorite, :to_be_cooked)
  end
end
