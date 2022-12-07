class PopulateRecipeVotesCount < ActiveRecord::Migration[7.0]
  def change
    Recipe.find_each do |recipe|
      Recipe.reset_counters(recipe.id, :votes)
    end
  end
end
