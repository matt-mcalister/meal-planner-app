class CreateRecipeIngredients < ActiveRecord::Migration[5.1]
  def change
    create_table :recipe_ingredients do |t|
      t.belongs_to :ingredient, foreign_key: true
      t.belongs_to :recipe, foreign_key: true
      t.integer :quantity_used
      t.string :unit_of_measurement

      t.timestamps
    end
  end
end
