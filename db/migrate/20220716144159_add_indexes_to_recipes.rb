class AddIndexesToRecipes < ActiveRecord::Migration[7.0]
  def self.up
    execute 'CREATE FULLTEXT INDEX index_recipes_on_title ON recipes (title)'
    add_index :recipes, :time
    add_index :recipes, :difficulty
  end

  def self.down
    execute 'DROP INDEX index_recipes_on_title ON recipes'
    remove_index :recipes, :time
    remove_index :recipes, :difficulty
  end
end
