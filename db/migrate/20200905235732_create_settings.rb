class CreateSettings < ActiveRecord::Migration[6.0]
  def change
    create_table :settings do |t|
      t.string :code
      t.string :value
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
