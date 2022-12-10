require 'swagger_helper'

RSpec.describe 'api/categories', type: :request do
  before do
    create(:category)
  end

  # jitera-hook-for-rswag-example

  path '/api/categories/{id}' do
    delete 'Destroy categories' do
      tags 'delete'
      consumes 'application/json'
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
        let(:id) { create(:category).id }

        run_test! do |response|
          expect(response.status).to eq(200)
        end
      end
    end
  end

  path '/api/categories/{id}' do
    put 'Update categories' do
      tags 'update'
      consumes 'application/json'
      parameter name: 'id', in: :path, type: 'string', description: 'id'
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          category: {
            type: :object,
            properties: {
              description: {
                type: :text,
                example: 'text'
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
                      'description' => 'text',
                      'recipes' => [{ 'id' => 'integer',
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
                                      'votes' => [{ 'info' => 'object' }] }] }

        }
        let(:id) { create(:category).id }

        let(:params) do
          {
            category: {
              description: 'This is a new description for category.'
            }
          }
        end

        run_test! do |response|
          expect(response.status).to eq(200)
        end
      end
    end
  end

  path '/api/categories/{id}' do
    get 'Show categories' do
      tags 'show'
      consumes 'application/json'
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
                      'description' => 'text',
                      'recipes' => [{ 'id' => 'integer',
                                      'created_at' => 'datetime',
                                      'updated_at' => 'datetime',
                                      'title' => 'string',
                                      'descriptions' => 'text',
                                      'time' => 'string',
                                      'difficulty' => 'enum_type',
                                      'category_id' => 'foreign_key',
                                      'owner_id' => 'foreign_key',
                                      'votes_cont' => 'integer',
                                      'ingredients' => [{ 'id' => 'integer',
                                                          'created_at' => 'datetime',
                                                          'updated_at' => 'datetime',
                                                          'unit' => 'enum_type',
                                                          'amount' => 'float',
                                                          'recipe_id' => 'foreign_key' }],
                                      'votes' => [{ 'info' => 'object' }] }] }

        }
        let(:params) {}
        let(:id) { create(:category).id }

        run_test! do |response|
          expect(response.status).to eq(200)
        end
      end
    end
  end

  path '/api/categories' do
    post 'Create categories' do
      tags 'create'
      consumes 'application/json'
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          category: {
            type: :object,
            properties: {
              description: {
                type: :text,
                example: 'text'
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
                      'recipes' => [{ 'id' => 'integer',
                                      'created_at' => 'datetime',
                                      'updated_at' => 'datetime',
                                      'title' => 'string',
                                      'descriptions' => 'text',
                                      'time' => 'string',
                                      'difficulty' => 'enum_type',
                                      'owner_id' => 'foreign_key',
                                      'votes_count' => 'integer',
                                      'description' => 'text',
                                      'ingredients' => [{ 'id' => 'integer',
                                                          'created_at' => 'datetime',
                                                          'updated_at' => 'datetime',
                                                          'unit' => 'enum_type',
                                                          'amount' => 'float',
                                                          'recipe_id' => 'foreign_key' }],
                                      'votes' => [{ 'info' => 'object' }] }] }
        }
        let(:params) do
          {
            category: {
              description: 'This is a description of category.'
            }
          }
        end
        run_test! do |response|
          expect(response.status).to eq(201)
        end
      end
    end
  end

  path '/api/categories' do
    get 'List categories' do
      tags 'index'
      consumes 'application/json'
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
        }
      }
      response '200', 'index' do
        examples 'application/json' => {
          'total_pages' => 'integer',

          'data' => [{ 'id' => 'integer',
                       'created_at' => 'datetime',
                       'updated_at' => 'datetime',
                       'description' => 'text',
                       'recipes' => [{ 'id' => 'integer',
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
                                       'votes' => [{ 'info' => 'object' }] }] }]
}
        let(:params) {}
        run_test! do |response|
          expect(response.status).to eq(200)
        end
      end
    end
  end
end
