class CreatePantryItems < ActiveRecord::Migration[5.1]
  def change
    create_table :pantry_items do |t|
      t.belongs_to :user, foreign_key: true
      t.belongs_to :ingredient, foreign_key: true
      t.integer :quantity_in_stock
      t.string :unit_of_measurement

      t.timestamps
    end
  end
end
