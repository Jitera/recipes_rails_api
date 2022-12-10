require 'rails_helper'

RSpec.describe ::Ingredients::GatherIngredientsService do
  describe '#call' do
    let(:recipe) { create(:recipe, time: '1 min - 10 mins') }
    let(:other_recipe) { create(:recipe, time: '2 mins - 10 mins') }
    let(:ingredients) { create_list(:ingredient, 3, recipe: recipe) }
    let(:ingredient) { create(:ingredient, recipe: other_recipe) }
    let(:params) do
      {
        term: {
          unit: '',
          recipe_id: ''
        }
      }
    end

    it 'returns a list of ingredients filtered by recipe_id' do
      ingredient_ids = ingredients.map(&:id).push(ingredient.id)
      params[:term][:recipe_id] = recipe.id
      result = ::Ingredients::GatherIngredientsService.call(Ingredient.where(id: ingredient_ids), params.stringify_keys)
      expect(result.size).to eq(3)
    end

    it 'returns a list of ingredients' do
      ingredient_ids = ingredients.map(&:id).push(ingredient.id)
      params[:term][:unit] = ingredient.unit
      result = ::Ingredients::GatherIngredientsService.call(Ingredient.where(id: ingredient_ids), {})
      expect(result.size).to eq(4)
    end
  end
end
