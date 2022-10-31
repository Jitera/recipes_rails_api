require 'swagger_helper'

RSpec.describe 'api/recipes/{recipe_id}/ratings', type: :request do
  path '/api/recipes/{recipe_id}/ratings' do
    get 'List ratings for a recipe' do
      tags 'filter'
      consumes 'application/json'

      security [bearerAuth: []]
      parameter name: 'recipe_id', in: :path, type: 'string', description: 'recipe_id'
      response '200', 'filter' do
        examples 'application/json' => {
        }
        let(:resource_owner) { create(:user) }
        let(:token) { create(:access_token, resource_owner: resource_owner).token }
        let(:Authorization) { "Bearer #{token}" }
        let(:recipe_id) { create(:recipe).id }
        run_test! do |response|
          expect(response.status).to eq(200)
        end
      end
    end
  end

  path '/api/recipes/{recipe_id}/ratings' do
    post 'Rate a recipe' do
      tags 'create'
      consumes 'application/json'

      security [bearerAuth: []]
      parameter name: 'recipe_id', in: :path, type: 'string', description: 'recipe_id'
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          rating: {
            type: :object,
            properties: {
              rating: {
                type: :integer,
                example: 5
              }
            }
          }
        }
      }
      response '200', 'create' do
        examples 'application/json' => {
          'rating' => {
            'id' => 'integer',
            "recipe_id" => "foreign_key",
            "rater_id" => "foreign_key",
            "rating" => "integer"
          }
        }
        let(:resource_owner) { create(:user) }
        let(:token) { create(:access_token, resource_owner: resource_owner).token }
        let(:Authorization) { "Bearer #{token}" }
        let(:recipe_id) { create(:recipe).id }
        let(:params) { { rating: { rating: 2 } } }
        run_test! do |response|
          expect(response.status).to eq(200)
        end
      end
    end
  end
end
