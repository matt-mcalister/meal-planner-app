class CreatePantryItems < ActiveRecord::Migration[5.1]
  def change
    create_table :pantry_items do |t|
      t.belongs_to :user, foreign_key: true
      t.belongs_to :ingredient, foreign_key: true
      t.boolean :in_stock, default: true

      t.timestamps
    end
  end
end
