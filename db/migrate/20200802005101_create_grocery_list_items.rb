class CreateGroceryListItems < ActiveRecord::Migration[6.0]
  def change
    create_table :grocery_list_items do |t|
      t.string :name
      t.float :cost
      t.float :qty
      t.integer :sort
      t.references :grocery_list_group, null: false, foreign_key: true

      t.timestamps
    end
  end
end
