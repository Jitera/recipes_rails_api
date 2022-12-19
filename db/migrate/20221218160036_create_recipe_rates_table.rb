class CreateRecipeRatesTable < ActiveRecord::Migration[7.0]
  def change
    create_table :recipe_rates do |t|
      t.references :user, null: false, foreign_key: true
      t.references :recipe, null: false, foreign_key: true
      t.integer :point, null: false
      t.index [:user_id, :recipe_id], unique: true
      t.timestamps
    end
  end
end
