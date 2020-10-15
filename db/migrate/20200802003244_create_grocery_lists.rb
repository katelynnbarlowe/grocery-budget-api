class CreateGroceryLists < ActiveRecord::Migration[6.0]
  def change
    create_table :grocery_lists do |t|
      t.string :name
      t.boolean :template
      t.float :total
      t.float :budget
      t.float :sales_tax
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
