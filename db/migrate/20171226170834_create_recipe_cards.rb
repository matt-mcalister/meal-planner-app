class CreateRecipeCards < ActiveRecord::Migration[5.1]
  def change
    create_table :recipe_cards do |t|
      t.belongs_to :user, foreign_key: true
      t.belongs_to :recipe, foreign_key: true
      t.integer :rating
      t.boolean :favorite, default: true

      t.timestamps
    end
  end
end
