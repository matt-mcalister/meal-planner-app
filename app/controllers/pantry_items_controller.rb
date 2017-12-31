class PantryItemsController < ApplicationController

  def index
    @ingredients_in_stock = current_user.ingredients_in_stock
    @grocery_list = current_user.grocery_list
    @user = current_user
    @pantry_item = PantryItem.new(user_id: @user.id)
  end

  def groceries
    @user = current_user
    @user.grocery_list.each do |ingredient|
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
    redirect_to method(params[:source]).call
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
