class AddVotesCountToRecipes < ActiveRecord::Migration[7.0]
  def change
    add_column :recipes, :votes_count, :integer, default: 0
  end
end
