class CreateRecipeCards < ActiveRecord::Migration[5.1]
  def change
    create_table :recipe_cards do |t|
      t.belongs_to :user, foreign_key: true
      t.belongs_to :recipe, foreign_key: true
      t.boolean :favorite, default: true
      t.boolean :to_be_cooked, default: false

      t.timestamps
    end
  end
end
