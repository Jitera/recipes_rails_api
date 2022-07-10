class CreateRatings < ActiveRecord::Migration[7.0]
  def change
    create_table :ratings do |t|
      t.integer :user_id, null: false
      t.integer :recipe_id, null: false
      t.integer :points, null: true
      t.string :comments, null: true
      t.timestamps
    end

    add_index :ratings, [:user_id, :recipe_id], unique: true
  end
end
