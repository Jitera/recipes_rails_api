# frozen_string_literal: true

RSpec.describe Ingredients::WeightConverter do
  let!(:service) do
    described_class.new(
      params
    )
  end

  describe '.call' do
    context 'when missing param' do
      let(:params) do
        {
          from_unit: 'gram',
          to_unit: 'kilogram'
        }
      end

      it 'service return error' do
        service.call
        expect(service.errors.first.to_s).to eq('missing param to convert')
      end
    end

    context 'when from_unit not in available list' do
      let(:params) do
        {
          from_unit: 'tan',
          to_unit: 'kilogram',
          from_amount: 100
        }
      end

      it 'service return error' do
        service.call
        expect(service.errors.first.to_s).to eq('unsupported unit')
      end
    end

    context 'when success and return to_unit in data' do
      let(:params) do
        {
          from_unit: 'kilogram',
          to_unit: 'gram',
          from_amount: 1
        }
      end
      let(:expected_result) do
        {
          from_unit: 'kilogram',
          to_unit: 'gram',
          from_amount: 1,
          to_amount: 1000
        }
      end

      it 'service success fail' do
        service.call
        expect(service.data).to eq(expected_result)
      end
    end
  end
end
