class CreateLists < ActiveRecord::Migration[6.0]
  def change
    create_table :lists do |t|
      t.string :description, null: false
      t.boolean :is_private, default: false
      t.string :previous_lists_ids, default: ''

      t.references :parent_list, foreign_key: { to_table: :lists }
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
