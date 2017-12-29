class CreateRecipes < ActiveRecord::Migration[5.1]
  def change
    create_table :recipes do |t|
      t.string :yield
      t.string :name
      t.string :total_cooking_time

      t.timestamps
    end
  end
end
