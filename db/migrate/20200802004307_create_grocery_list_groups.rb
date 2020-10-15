class CreateGroceryListGroups < ActiveRecord::Migration[6.0]
  def change
    create_table :grocery_list_groups do |t|
      t.string :name
      t.integer :sort
      t.references :grocery_list, null: false, foreign_key: true

      t.timestamps
    end
  end
end
