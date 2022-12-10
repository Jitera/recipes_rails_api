require 'swagger_helper'

RSpec.describe 'api/recipes', type: :request do
  let(:resource_owner) { create(:user) }
  let(:other_user) { create(:user) }
  let(:category) { create(:category) }
  let(:recipe) { create(:recipe, time: '1 min - 10 mins', user_id: resource_owner.id, category_id: category.id) }
  let(:other_recipe) { create(:recipe, time: '1 min - 10 mins', user_id: other_user.id, category_id: category.id) }
  let(:token) { create(:access_token, resource_owner: resource_owner).token }
  let(:Authorization) { "Bearer #{token}" }

  # jitera-hook-for-rswag-example

  path '/api/recipes/{id}' do
    delete 'Destroy recipes' do
      tags 'delete'
      consumes 'application/json'
      security [bearerAuth: []]

      parameter name: 'id', in: :path, type: 'string', description: 'id'
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
        }
      }
      response '200', 'delete' do
        examples 'application/json' => {
          'data' => nil
        }
        let(:params) {}
        let(:id) { recipe.id }

        run_test! do |response|
          expect(response.status).to eq(200)
        end
      end
    end
  end

  path '/api/recipes/{id}' do
    put 'Update recipes' do
      tags 'update'
      consumes 'application/json'

      security [bearerAuth: []]
      parameter name: 'id', in: :path, type: 'string', description: 'id'
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          recipe: {
            type: :object,
            properties: {
              title: {
                type: :string,
                example: 'string'
              },
              descriptions: {
                type: :text,
                example: 'text'
              },
              time: {
                type: :string,
                example: 'string'
              },
              difficulty: {
                type: :enum_type,
                example: 'enum_type'
              },
              category_id: {
                type: :foreign_key,
                example: 'foreign_key'
              },
              user_id: {
                type: :foreign_key,
                example: 'foreign_key'
              }
            }
          }
        }
      }
      response '200', 'update' do
        examples 'application/json' => {
          'data' => { 'id' => 'integer',
                      'created_at' => 'datetime',
                      'updated_at' => 'datetime',
                      'title' => 'string',
                      'descriptions' => 'text',
                      'time' => 'string',
                      'difficulty' => 'enum_type',
                      'category_id' => 'foreign_key',
                      'owner_id' => 'foreign_key',
                      'votes_count' => 'integer',
                      'ingredients' => [{ 'id' => 'integer',
                                          'created_at' => 'datetime',
                                          'updated_at' => 'datetime',
                                          'unit' => 'enum_type',
                                          'amount' => 'float',
                                          'recipe_id' => 'foreign_key' }],
                      'votes' => [{ 'info' => 'object' }] }
        }

        let(:id) { recipe.id }
        let(:params) do
          {
            recipe: {
              time: '2 mins - 10 mins'
            }
          }
        end

        run_test! do |response|
          expect(response.status).to eq(200)
        end
      end
    end
  end

  path '/api/recipes/{id}' do
    get 'Show recipes' do
      tags 'show'
      consumes 'application/json'

      security [bearerAuth: []]
      parameter name: 'id', in: :path, type: 'string', description: 'id'
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
        }
      }
      response '200', 'show' do
        examples 'application/json' => {
          'data' => { 'id' => 'integer',
                      'created_at' => 'datetime',
                      'updated_at' => 'datetime',
                      'title' => 'string',
                      'descriptions' => 'text',
                      'time' => 'string',
                      'difficulty' => 'enum_type',
                      'category_id' => 'foreign_key',
                      'user_id' => 'foreign_key',
                      'ingredients' => [{ 'id' => 'integer',
                                          'created_at' => 'datetime',
                                          'updated_at' => 'datetime',
                                          'unit' => 'enum_type',
                                          'amount' => 'float',
                                          'recipe_id' => 'foreign_key' }],
                      'votes' => [{ 'info' => 'object' }] }
        }

        let(:params) {}
        let(:id) { recipe.id }

        run_test! do |response|
          expect(response.status).to eq(200)
        end
      end
    end
  end

  path '/api/recipes/{recipe_id}/vote' do
    post 'Vote recipes' do
      tags 'vote'
      consumes 'application/json'

      security [bearerAuth: []]
      parameter name: 'recipe_id', in: :path, type: 'string', description: 'recipe_id'
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
        }
      }
      response '201', 'show' do
        examples 'application/json' => {
          'message' => I18n.t('recipes.vote_successfully')
        }

        let(:params) {}
        let(:recipe_id) { other_recipe.id }

        run_test! do |response|
          expect(response.status).to eq(201)
        end
      end
    end
  end

  path '/api/recipes/{recipe_id}/unvote' do
    delete 'Unvote recipes' do
      tags 'unvote'
      consumes 'application/json'

      security [bearerAuth: []]
      parameter name: 'recipe_id', in: :path, type: 'string', description: 'recipe_id'
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
        }
      }
      response '200', 'show' do
        examples 'application/json' => {
          'message' => I18n.t('recipes.unvote_successfully')
        }

        let(:params) {}
        let(:recipe_id) { other_recipe.id }

        run_test! do |response|
          expect(response.status).to eq(200)
        end
      end
    end
  end

  path '/api/recipes' do
    post 'Create recipes' do
      tags 'create'
      consumes 'application/json'

      security [bearerAuth: []]
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          recipes: {
            type: :object,
            properties: {
              title: {
                type: :string,
                example: 'string'
              },
              descriptions: {
                type: :text,
                example: 'text'
              },
              time: {
                type: :string,
                example: 'string'
              },
              difficulty: {
                type: :enum_type,
                example: 'enum_type'
              },
              category_id: {
                type: :foreign_key,
                example: 'foreign_key'
              },
              user_id: {
                type: :foreign_key,
                example: 'foreign_key'
              }
            }
          }
        }
      }
      response '201', 'create' do
        examples 'application/json' => {
          'data' => { 'id' => 'integer',
                      'created_at' => 'datetime',
                      'updated_at' => 'datetime',
                      'title' => 'string',
                      'descriptions' => 'text',
                      'time' => 'string',
                      'difficulty' => 'enum_type',
                      'category_id' => 'foreign_key',
                      'owner_id' => 'foreign_key',
                      'ingredients' => [{ 'id' => 'integer',
                                          'created_at' => 'datetime',
                                          'updated_at' => 'datetime',
                                          'unit' => 'enum_type',
                                          'amount' => 'float',
                                          'recipe_id' => 'foreign_key' }],
                      'votes' => [{ 'info' => 'object' }] }
        }
        let(:id) { recipe.id }
        let(:params) do
          {
            recipe: { time: '1 min - 10 mins',
                       title: 'This is a title of the recipe',
                       descriptions: 'This is a descriptions of the recipe',
                       difficulty: 'easy',
                       category_id: category.id,
                       user_id: resource_owner.id }
          }
        end

        run_test! do |response|
          expect(response.status).to eq(201)
        end
      end
    end
  end

  path '/api/recipes' do
    get 'List recipes' do
      tags 'filter'
      consumes 'application/json'

      security [bearerAuth: []]
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
        }
      }
      response '200', 'filter' do
        examples 'application/json' => {
          'total_pages' => 'integer',
          'data' => [{ 'id' => 'integer',
                       'created_at' => 'datetime',
                       'updated_at' => 'datetime',
                       'title' => 'string',
                       'descriptions' => 'text',
                       'time' => 'string',
                       'difficulty' => 'enum_type',
                       'category_id' => 'foreign_key',
                       'owner_id' => 'foreign_key',
                       'ingredients' => [{ 'id' => 'integer',
                                           'created_at' => 'datetime',
                                           'updated_at' => 'datetime',
                                           'unit' => 'enum_type',
                                           'amount' => 'float',
                                           'recipe_id' => 'foreign_key' }] }]
        }
        let(:params) {}

        run_test! do |response|
          expect(response.status).to eq(200)
        end
      end
    end
  end
end
