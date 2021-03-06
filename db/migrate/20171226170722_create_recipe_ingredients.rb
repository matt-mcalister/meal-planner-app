class CreateRecipeIngredients < ActiveRecord::Migration[5.1]
  def change
    create_table :recipe_ingredients do |t|
      t.belongs_to :ingredient, foreign_key: true
      t.belongs_to :recipe, foreign_key: true
      t.float :quantity_used
      t.string :unit_of_measurement
      t.string :extra_instructions, default: ""

      t.timestamps
    end
  end
end
