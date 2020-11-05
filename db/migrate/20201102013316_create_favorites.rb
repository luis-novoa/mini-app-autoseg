class CreateFavorites < ActiveRecord::Migration[6.0]
  def change
    create_table :favorites do |t|
      t.references :user, foreign_key: true, null: false
      t.references :list, foreign_key: true, null: false
      t.string :user_list, null: false, unique: true

      t.timestamps
    end

    add_index :favorites, :user_list, unique: true
  end
end
