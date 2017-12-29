class CreateInstructions < ActiveRecord::Migration[5.1]
  def change
    create_table :instructions do |t|
      t.belongs_to :recipe, foreign_key: true
      t.integer :instruction_number
      t.string :instruction_text
    end
  end
end
