class PantryItemsController < ApplicationController

  def index
    @ingredients_in_stock = current_user.ingredients_in_stock
    @grocery_list = current_user.grocery_list
    @user = current_user
    @pantry_item = PantryItem.new(user_id: @user.id)

    if params[:ingredient_name]
      @ingredients_in_stock = @ingredients_in_stock.select {|ingredient| ingredient.name.downcase.include?(params[:ingredient_name].downcase)}
      @grocery_list = @grocery_list.select {|ingredient| ingredient.name.downcase.include?(params[:ingredient_name].downcase)}
    end
  end

  def groceries
    @user = current_user
    if params[:recipe_id]
      ingredients_to_purchase = @user.ingredients_needed_for_recipe(params[:recipe_id])
    else
      ingredients_to_purchase = @user.grocery_list
    end

    ingredients_to_purchase.each do |ingredient|
      pantry_item = PantryItem.find_or_initialize_by(ingredient_id: ingredient.id, user_id: @user.id)
      pantry_item.in_stock = true
      if pantry_item.valid?
        pantry_item.save
      else
        byebug
        flash[:error] ||= []
        flash[:error] << pantry_item.errors.full_messages
      end
    end

    if flash[:error]
      flash[:error] = flash[:error].flatten
    end
    if params[:source] == "user_path(current_user)"
      redirect_to user_path(current_user)
    else
      redirect_to method(params[:source]).call
    end
  end

  def create
    @pantry_item = PantryItem.new(pantry_item_params)
    if @pantry_item.valid?
      @pantry_item.save
    else
      flash[:error] = @pantry_item.errors.full_messages
    end
    redirect_to method(params[:source]).call
  end

  def update
    @pantry_item = PantryItem.find(params[:id])

    if !@pantry_item.update(pantry_item_params)
      flash[:error] = @pantry_item.errors.full_messages
    end
    redirect_to method(params[:source]).call
  end

  def destroy
    @pantry_item = PantryItem.find(params[:id])
    @pantry_item.destroy
    redirect_to pantry_items_path
  end

  private
    def pantry_item_params
      params.require(:pantry_item).permit(:user_id, :ingredient_id, :in_stock)
    end
end
