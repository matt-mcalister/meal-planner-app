class PantryItemsController < ApplicationController
  def index
    @pantry_items = PantryItem.all.select {|item| item.user_id == current_user.id}
  end

  def create_grocery
    @pantry_item = PantryItem.new(quantity_in_stock: 0, ingredient_id: params[:id], )
  end

  def edit
    @pantry_item = PantryItem.find(params[:id])
  end

  def update
    @pantry_item = PantryItem.find(params[:id])

    if @pantry_item.update(pantry_item_params)
      redirect_to pantry_items_path
    else
      flash[:error] = @pantry_item.errors.full_messages
      redirect_to pantry_items_path
    end
  end

  def destroy
    @pantry_item = PantryItem.find(params[:id])
    @pantry_item.destroy
    redirect_to pantry_items_path
  end

  private
    def pantry_item_params
      params.require(:pantry_item).permit(:quantity_in_stock, :unit_of_measurement)
    end
end
