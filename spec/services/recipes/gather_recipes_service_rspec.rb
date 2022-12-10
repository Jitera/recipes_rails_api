require 'rails_helper'

RSpec.describe ::Recipes::GatherRecipesService do
  describe '#call' do
    let(:recipe) { create(:recipe, difficulty: 'normal', time: '2 mins - 1 hour 30 mins') }
    let(:recipes) { create_list(:recipe, 3, time: '2 mins - 9 mins') }
    let(:params) do
      {
        term: {
          title: '',
          difficulty: '',
          time: ''
        }
      }
    end

    it 'returns a list of recipes filtered by title' do
      recipe_ids = recipes.map(&:id).push(recipe.id)
      params[:term][:title] = recipe.title
      result = ::Recipes::GatherRecipesService.call(Recipe.where(id: recipe_ids), params.stringify_keys)
      expect(result.size).to eq(1)
    end

    it 'returns a list of recipes filtered by difficulty' do
      recipe_ids = recipes.map(&:id).push(recipe.id)
      params[:term][:difficulty] = 'easy'
      result = ::Recipes::GatherRecipesService.call(Recipe.where(id: recipe_ids), params.stringify_keys)
      expect(result.size).to eq(3)
    end

    it 'returns a list of recipes filtered by time' do
      recipe_ids = recipes.map(&:id)
      params[:term][:time] = '2 mins - 9 mins'
      result = ::Recipes::GatherRecipesService.call(Recipe.where(id: recipe_ids), params.stringify_keys)
      expect(result.size).to eq(3)
    end
  end
end
