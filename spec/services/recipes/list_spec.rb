# frozen_string_literal: true

# rubocop:disable RSpec/MultipleMemoizedHelpers
RSpec.describe Recipes::List do
  let!(:service) do
    described_class.new(
      params
    )
  end
  let!(:category1) { create(:category) }
  let!(:category2) { create(:category) }
  let(:user1) { create(:user) }
  let(:user2) { create(:user) }
  let!(:recipe1) { create(:recipe, difficulty: 'easy', title: 'Title 1', descriptions: 'Descriptions 1', category: category1, user: user1, time: '15') }
  let!(:recipe2) { create(:recipe, difficulty: 'normal', title: 'Title 2', descriptions: 'Descriptions 2', category: category2, user: user2, time: '40') }
  let!(:recipe3) { create(:recipe, difficulty: 'challenging', title: 'Title 3', descriptions: 'Descriptions 3', category: category1, user: user1, time: '5') }

  describe '.call' do

    context 'when filter by title' do
      let(:params) do
        {
          title: '1'
        }
      end
      let(:expected_result) { [recipe1.id] }

      it 'successes and return expected result' do
        service.call
        expect(service.data.map(&:id)).to eq(expected_result)
      end
    end

    context 'when filter by time mins' do
      let(:params) do
        {
          time: '12mins - 30mins'
        }
      end
      let(:expected_result) { [recipe1.id] }

      it 'successes and return expected result with' do
        service.call
        expect(service.data.map(&:id)).to eq(expected_result)
      end
    end

    context 'when filter by time hour' do
      let(:params) do
        {
          time: '20mins - 1hour'
        }
      end
      let(:expected_result) { [recipe2.id] }

      it 'successes and return expected result with' do
        service.call
        expect(service.data.map(&:id)).to eq(expected_result)
      end
    end

    context 'when filter by descriptions' do
      let(:params) do
        {
          descriptions: '2'
        }
      end
      let(:expected_result) { [recipe2.id] }

      it 'successes and return expected result with time mins' do
        service.call
        expect(service.data.map(&:id)).to eq(expected_result)
      end
    end

    context 'when filter by difficulty' do
      let(:params) do
        {
          difficulty: 'challenging'
        }
      end
      let(:expected_result) { [recipe3.id] }

      it 'successes and return expected result' do
        service.call
        expect(service.data.map(&:id)).to eq(expected_result)
      end
    end

    context 'when filter by user_id' do
      let(:params) do
        {
          user_id: user1.id
        }
      end
      let(:expected_result) { [recipe1.id, recipe3.id] }

      it 'successes and return expected result' do
        service.call
        expect(service.data.map(&:id)).to eq(expected_result)
      end
    end

    context 'when combine many filter' do
      let(:params) do
        {
          difficulty: 'easy',
          time: '10mins - 15mins',
          title: '1'
        }
      end
      let(:expected_result) { [recipe1.id] }

      it 'successes and return expected result' do
        service.call
        expect(service.data.map(&:id)).to eq(expected_result)
      end
    end

  end
end
# rubocop:enable RSpec/MultipleMemoizedHelpers
