require 'swagger_helper'

RSpec.describe 'api/converters', type: :request do
  path '/api/converters/convert' do
    get 'Make conversion' do
      consumes 'application/json'
      parameter name: :from_amount, in: :query, type: :string
      parameter name: :from_unit, in: :query, type: :string
      parameter name: :to_unit, in: :query, type: :string

      response '200', 'successful' do
        let(:from_amount) { 1 }
        let(:from_unit) { 'cup' }
        let(:to_unit) { 'teaspoons' }
        run_test! do |response|
          puts response.body.inspect
          expect(response.status).to eq(200)
          expect(JSON.parse(response.body)).to eq({ "to_unit" => 'teaspoons', "to_amount" => 48.0 })
        end
      end

      response '400', 'invalid parameters' do
        [
          { from_unit: 'cup', to_unit: 'teaspoons' },
          { from_unit: 'cup', from_amount: 1.1 },
          { from_unit: 'cup_x', from_amount: 1.1, to_unit: 'teaspoons' },
          { from_unit: 'cup', from_amount: 'a', to_unit: 'teaspoons' }
        ].each do |params|
          let(:from_amount) { params[:from_amount] }
          let(:from_unit) { params[:from_unit] }
          let(:to_unit) { params[:to_unit] }

          run_test! do |response|
            expect(response.status).to eq(400)
          end
        end
      end
    end
  end
end
