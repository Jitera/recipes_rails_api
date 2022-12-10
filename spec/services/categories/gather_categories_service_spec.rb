require 'rails_helper'

RSpec.describe ::Categories::GatherCategoriesService do
  describe '#call' do
    let(:categories) { create_list(:category, 3) }
    let(:target_category) { create(:category, description: 'this is test') }
    let(:params) do
      {
        term: {
          description: ''
        }
      }
    end

    it 'returns a list of categories filtered by description' do
      category_ids = categories.map(&:id).push(target_category.id)
      params[:term][:description] = target_category.description
      result = ::Categories::GatherCategoriesService.call(Category.where(id: category_ids), params.stringify_keys)
      expect(result.first.id).to eq(target_category.id)
    end

    it 'returns a list of categories' do
      category_ids = categories.map(&:id).push(target_category.id)
      params[:term] = {}
      result = ::Categories::GatherCategoriesService.call(Category.where(id: category_ids), params.stringify_keys)
      expect(result.size).to eq(4)
    end
  end
end
