class CreateLists < ActiveRecord::Migration[6.0]
  def change
    create_table :lists do |t|
      t.string :description, null: false
      t.boolean :private, null: false, default: false
      t.string :previous_lists_id

      t.references :parent_list, foreign_key: { to_table: :lists }

      t.timestamps
    end
  end
end
