require 'swagger_helper'

RSpec.describe 'api/units', type: :request do

  # jitera-hook-for-rswag-example

  path '/api/units/convert' do

    after do |example|
      example.metadata[:response][:content] = {
        'application/json' => {
          examples: {
            example.metadata[:example_group][:description] => {
              value: JSON.parse(response.body, symbolize_names: true)
            }
          }
        }
      }
    end

    get 'Convert from one unit to another' do
      tags 'units'
      consumes 'application/json'
      security [bearerAuth: []]

      parameter name: :from, in: :query, type: :string, required: false
      parameter name: :to, in: :query, type: :string, required: false
      parameter name: :amount, in: :query, type: :number, required: false

      response '200', 'search recipes' do
        schema type: :object,
               properties: {
                 from: {
                   type: :object,
                   properties: {
                     from: {
                       type: :string
                     },
                     value: {
                       type: :number
                     },
                   }
                 },
                 to: {
                   type: :object,
                   properties: {
                     from: {
                       type: :string
                     },
                     value: {
                       type: :number
                     },
                   }
                 }
               }

        context 'no parameters' do
          let(:resource_owner) { create(:user) }
          let(:token) { create(:access_token, resource_owner: resource_owner).token }
          let(:Authorization) { "Bearer #{token}" }

          run_test! do |response|
            data = JSON.parse(response.body).with_indifferent_access
            expect(data[:from][:unit]).to eq(nil)
            expect(data[:from][:value]).to eq(0)
            expect(data[:to][:unit]).to eq(nil)
            expect(data[:to][:value]).to eq(-1)
          end
        end

        context 'supported from unit' do
          let(:resource_owner) { create(:user) }
          let(:token) { create(:access_token, resource_owner: resource_owner).token }
          let(:Authorization) { "Bearer #{token}" }
          let(:from) { 'kilogram' }
          run_test! do |response|
            data = JSON.parse(response.body).with_indifferent_access
            expect(data[:from][:unit]).to eq('kilogram')
            expect(data[:from][:value]).to eq(0)
            expect(data[:to][:unit]).to eq(nil)
            expect(data[:to][:value]).to eq(-1)
          end
        end

        context 'supported from unit & amount' do
          let(:resource_owner) { create(:user) }
          let(:token) { create(:access_token, resource_owner: resource_owner).token }
          let(:Authorization) { "Bearer #{token}" }
          let(:from) { 'kilogram' }
          let(:amount) { 2 }
          run_test! do |response|
            data = JSON.parse(response.body).with_indifferent_access
            expect(data[:from][:unit]).to eq('kilogram')
            expect(data[:from][:value]).to eq(2)
            expect(data[:to][:unit]).to eq(nil)
            expect(data[:to][:value]).to eq(-1)
          end
        end

        context 'supported from, to unit & amount' do
          let(:resource_owner) { create(:user) }
          let(:token) { create(:access_token, resource_owner: resource_owner).token }
          let(:Authorization) { "Bearer #{token}" }
          let(:from) { 'kilogram' }
          let(:amount) { 2 }
          let(:to) { 'gram' }
          run_test! do |response|
            data = JSON.parse(response.body).with_indifferent_access
            expect(data[:from][:unit]).to eq('kilogram')
            expect(data[:from][:value]).to eq(2)
            expect(data[:to][:unit]).to eq('gram')
            expect(data[:to][:value]).to eq(2000)
          end
        end

        context 'unsupported from unit' do
          let(:resource_owner) { create(:user) }
          let(:token) { create(:access_token, resource_owner: resource_owner).token }
          let(:Authorization) { "Bearer #{token}" }
          let(:from) { 'xxx' }
          let(:amount) { 2 }
          let(:to) { 'gram' }
          run_test! do |response|
            data = JSON.parse(response.body).with_indifferent_access
            expect(data[:from][:unit]).to eq('xxx')
            expect(data[:from][:value]).to eq(2)
            expect(data[:to][:unit]).to eq('gram')
            expect(data[:to][:value]).to eq(-1)
          end
        end

        context 'unsupported to unit' do
          let(:resource_owner) { create(:user) }
          let(:token) { create(:access_token, resource_owner: resource_owner).token }
          let(:Authorization) { "Bearer #{token}" }
          let(:from) { 'cup' }
          let(:amount) { 2 }
          let(:to) { 'yyy' }
          run_test! do |response|
            data = JSON.parse(response.body).with_indifferent_access
            expect(data[:from][:unit]).to eq('cup')
            expect(data[:from][:value]).to eq(2)
            expect(data[:to][:unit]).to eq('yyy')
            expect(data[:to][:value]).to eq(-1)
          end
        end

        context 'bridge from, to unit & amount' do
          let(:resource_owner) { create(:user) }
          let(:token) { create(:access_token, resource_owner: resource_owner).token }
          let(:Authorization) { "Bearer #{token}" }
          let(:from) { 'teaspoons' }
          let(:amount) { 4 }
          let(:to) { 'cup' }
          run_test! do |response|
            data = JSON.parse(response.body).with_indifferent_access
            expect(data[:from][:unit]).to eq('teaspoons')
            expect(data[:from][:value]).to eq(4)
            expect(data[:to][:unit]).to eq('cup')
            expect(data[:to][:value]).to eq(0.1778125)
          end
        end

        context 'bridge from, to unit & amount' do
          let(:resource_owner) { create(:user) }
          let(:token) { create(:access_token, resource_owner: resource_owner).token }
          let(:Authorization) { "Bearer #{token}" }
          let(:from) { 'cup' }
          let(:amount) { 0.1778125 }
          let(:to) { 'teaspoons' }
          run_test! do |response|
            data = JSON.parse(response.body).with_indifferent_access
            expect(data[:from][:unit]).to eq('cup')
            expect(data[:from][:value]).to eq(0.1778125)
            expect(data[:to][:unit]).to eq('teaspoons')
            expect(data[:to][:value]).to eq(4)
          end
        end
      end
    end
  end
end
