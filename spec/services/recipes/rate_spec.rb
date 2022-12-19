# frozen_string_literal: true

RSpec.describe Recipes::Rate do
  let(:recipe) { create(:recipe) }
  let(:user) { create(:user) }
  let(:service) do
    described_class.new(
      recipe,
      params
    )
  end

  describe 'call' do
    context 'when missing point' do
      let(:params) do
        {
          user_id: user.id
        }
      end

      it 'return error missing point' do
        service.call
        expect(service.errors.first.to_s).to eq('missing point in params')
      end
    end

    context 'when success' do
      let(:params) do
        {
          user_id: user.id,
          point: 3
        }
      end

      it 'return success' do
        service.call
        expect(service.success?).to eq(true)
      end

    end

  end
end
