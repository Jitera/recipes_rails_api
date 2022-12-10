require 'rails_helper'

RSpec.describe ::Ingredients::ConvertWeightService do
  describe '#call' do
    let(:recipe) { create(:recipe, time: '1 min - 10 mins') }
    let(:ingredient) { create(:ingredient, recipe: recipe) }
    let(:ingredient_has_kilogram_unit) { create(:ingredient, unit: 'kilogram', recipe: recipe) }

    it 'returns -1 if ingredient has unit other than kilogram OR gram' do
      result = ::Ingredients::ConvertWeightService.call(ingredient.amount, ingredient.unit)
      expect(result).to eq(-1)
    end

    it 'returns value if ingredient has unit kilogram OR gram' do
      result = ::Ingredients::ConvertWeightService.call(ingredient_has_kilogram_unit.amount, ingredient_has_kilogram_unit.unit)
      expect(result).to eq(1_000.0)
    end
  end
end
