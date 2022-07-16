require 'swagger_helper'

# TODO: examples of rswag should be auto-generated instead of hand-crafted, so in case of changes, the examples alway reflect updated version
# TODO: checking only http response status code is really just for fun, should at least match against the schema

RSpec.describe 'api/recipes', type: :request do
  before do
    create(:recipe)
  end

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
          'recipes' => {
            'id' => 'integer',

            'created_at' => 'datetime',

            'updated_at' => 'datetime',

            'title' => 'string',

            'descriptions' => 'text',

            'time' => 'string',

            'difficulty' => 'enum_type',

            'category_id' => 'foreign_key',

            'ingredients' =>
  [
    {

      'id' => 'integer',

      'created_at' => 'datetime',

      'updated_at' => 'datetime',

      'unit' => 'enum_type',

      'amount' => 'float',

      'recipe_id' => 'foreign_key'

    }
  ],

            'user_id' => 'foreign_key'

          },

          'error_message' => 'string'

        }

        let(:resource_owner) { create(:user) }
        let(:token) { create(:access_token, resource_owner: resource_owner).token }
        let(:Authorization) { "Bearer #{token}" }
        let(:params) {}
        let(:id) { create(:recipe).id }

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
      response '200', 'update' do
        examples 'application/json' => {
          'recipes' => {
            'id' => 'integer',

            'created_at' => 'datetime',

            'updated_at' => 'datetime',

            'title' => 'string',

            'descriptions' => 'text',

            'time' => 'string',

            'difficulty' => 'enum_type',

            'category_id' => 'foreign_key',

            'ingredients' =>
  [
    {

      'id' => 'integer',

      'created_at' => 'datetime',

      'updated_at' => 'datetime',

      'unit' => 'enum_type',

      'amount' => 'float',

      'recipe_id' => 'foreign_key'

    }
  ],

            'user_id' => 'foreign_key'

          },

          'error_object' => {}

        }

        let(:resource_owner) { create(:user) }
        let(:token) { create(:access_token, resource_owner: resource_owner).token }
        let(:Authorization) { "Bearer #{token}" }
        let(:id) { create(:recipe).id }

        let(:params) {}
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
          'recipes' => {
            'id' => 'integer',

            'created_at' => 'datetime',

            'updated_at' => 'datetime',

            'title' => 'string',

            'descriptions' => 'text',

            'time' => 'string',

            'difficulty' => 'enum_type',

            'category_id' => 'foreign_key',

            'ingredients' =>
  [
    {

      'id' => 'integer',

      'created_at' => 'datetime',

      'updated_at' => 'datetime',

      'unit' => 'enum_type',

      'amount' => 'float',

      'recipe_id' => 'foreign_key'

    }
  ],

            'user_id' => 'foreign_key'

          },

          'error_message' => 'string'

        }

        let(:resource_owner) { create(:user) }
        let(:token) { create(:access_token, resource_owner: resource_owner).token }
        let(:Authorization) { "Bearer #{token}" }
        let(:params) {}
        let(:id) { create(:recipe).id }

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
      response '200', 'create' do
        examples 'application/json' => {
          'recipes' => {
            'id' => 'integer',

            'created_at' => 'datetime',

            'updated_at' => 'datetime',

            'title' => 'string',

            'descriptions' => 'text',

            'time' => 'string',

            'difficulty' => 'enum_type',

            'category_id' => 'foreign_key',

            'ingredients' =>
  [
    {

      'id' => 'integer',

      'created_at' => 'datetime',

      'updated_at' => 'datetime',

      'unit' => 'enum_type',

      'amount' => 'float',

      'recipe_id' => 'foreign_key'

    }
  ],

            'user_id' => 'foreign_key'

          },

          'error_object' => {}

        }
        let(:params) {}
        run_test! do |response|
          expect(response.status).to eq(200)
        end
      end
    end
  end

  path '/api/recipes' do
    get 'List recipes' do
      tags 'filter'
      consumes 'application/json'

      security [bearerAuth: []]
      # TODO: these are not correct since query parameter are not used for filtering, and is not in body, but should be in query instead
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
          },
          pagination_page: {
            type: :pagination_page,
            example: 'pagination_page'
          },
          pagination_limit: {
            type: :pagination_limit,
            example: 'pagination_limit'
          }
        }
      }
      response '200', 'filter' do
        examples 'application/json' => {
          'total_pages' => 'integer',

          'recipes' =>
        [
          {

            'id' => 'integer',

            'created_at' => 'datetime',

            'updated_at' => 'datetime',

            'title' => 'string',

            'descriptions' => 'text',

            'time' => 'string',

            'difficulty' => 'enum_type',

            'category_id' => 'foreign_key',

            'ingredients' =>
        [
          {

            'id' => 'integer',

            'created_at' => 'datetime',

            'updated_at' => 'datetime',

            'unit' => 'enum_type',

            'amount' => 'float',

            'recipe_id' => 'foreign_key'

          }
        ],

            'user_id' => 'foreign_key'

          }
        ],

          'error_message' => 'string'

        }

        let(:resource_owner) { create(:user) }
        let(:token) { create(:access_token, resource_owner: resource_owner).token }
        let(:Authorization) { "Bearer #{token}" }
        let(:params) {}
        run_test! do |response|
          expect(response.status).to eq(200)
        end
      end
    end
  end

  path '/api/recipes/search' do

    before(:all) do
      (0..95).each do |idx|
        create(:recipe, title: "Chicken soup for the soul #{idx + 1}", time: '120', updated_at: Time.now - idx.days)
      end
    end

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

    get 'Search recipes' do
      tags 'recipes'
      consumes 'application/json'
      security [bearerAuth: []]

      parameter name: :title, in: :query, type: :string, required: false
      parameter name: :time_from, in: :query, type: :number, required: false
      parameter name: :time_to, in: :query, type: :number, required: false
      parameter name: :'difficulties[]', in: :query, type: :array, required: false, collectionFormat: :multi
      parameter name: :per_page, in: :query, type: :number, required: false
      parameter name: :page, in: :query, type: :number, required: false

      response '200', 'search recipes' do
        schema type: :object,
               properties: {
                 recipes: {
                   type: :array,
                   items: {
                     type: :object,
                     properties: {
                       id: {
                         type: :number
                       },
                       created_at: {
                         type: :string
                       },
                       updated_at: {
                         type: :string
                       },
                       title: {
                         type: :string
                       },
                       description: {
                         type: :string
                       },
                       time: {
                         type: :string
                       },
                       difficulty: {
                         type: :string
                       },
                       category_id: {
                         type: :number
                       },
                       user_id: {
                         type: :number
                       },
                       ingredients: {
                         type: :array,
                         items: {
                           type: :object,
                           properties: {
                             id: {
                               type: :number
                             },
                             created_at: {
                               type: :string
                             },
                             updated_at: {
                               type: :string
                             },
                             unit: {
                               type: :string
                             },
                             amount: {
                               type: :number
                             },
                             recipe_id: {
                               type: :number
                             },
                           }
                         }
                       }
                     }
                   }
                 }
               }

        context 'all recipes found' do
          let(:resource_owner) { create(:user) }
          let(:token) { create(:access_token, resource_owner: resource_owner).token }
          let(:Authorization) { "Bearer #{token}" }

          run_test! do |response|
            data = JSON.parse(response.body).with_indifferent_access
            expect(data[:recipes].size).to eq(10)
            expect(data[:total_pages]).to eq(10)
            expect(data[:current_page]).to eq(1)
            expect(data[:total_count]).to eq(97)
          end
        end

        context 'matched recipes found' do
          let(:resource_owner) { create(:user) }
          let(:token) { create(:access_token, resource_owner: resource_owner).token }
          let(:Authorization) { "Bearer #{token}" }
          let(:title) { 'Chicken' }

          run_test! do |response|
            data = JSON.parse(response.body).with_indifferent_access
            expect(data[:recipes].size).to eq(10)
            expect(data[:total_pages]).to eq(10)
            expect(data[:current_page]).to eq(1)
            expect(data[:total_count]).to eq(96)
          end
        end

        context 'matched recipes found, page 5' do
          let(:resource_owner) { create(:user) }
          let(:token) { create(:access_token, resource_owner: resource_owner).token }
          let(:Authorization) { "Bearer #{token}" }
          let(:title) { 'Chicken' }
          let(:page) { 5 }

          run_test! do |response|
            data = JSON.parse(response.body).with_indifferent_access
            expect(data[:recipes].size).to eq(10)
            expect(data[:total_pages]).to eq(10)
            expect(data[:current_page]).to eq(5)
            expect(data[:total_count]).to eq(96)
          end
        end

        context 'matched recipes found page, 5 with 7 on each page' do
          let(:resource_owner) { create(:user) }
          let(:token) { create(:access_token, resource_owner: resource_owner).token }
          let(:Authorization) { "Bearer #{token}" }
          let(:title) { 'Chicken' }
          let(:page) { 5 }
          let(:per_page) { 7 }

          run_test! do |response|
            data = JSON.parse(response.body).with_indifferent_access
            expect(data[:recipes].size).to eq(7)
            expect(data[:total_pages]).to eq(14)
            expect(data[:current_page]).to eq(5)
            expect(data[:total_count]).to eq(96)
          end
        end

        context 'matched recipes found' do
          let(:resource_owner) { create(:user) }
          let(:token) { create(:access_token, resource_owner: resource_owner).token }
          let(:Authorization) { "Bearer #{token}" }
          let(:title) { 'Chicken soup for the soul 2' }

          run_test! do |response|
            data = JSON.parse(response.body).with_indifferent_access
            expect(data[:recipes].size).to eq(10)
            expect(data[:total_pages]).to eq(10)
            expect(data[:current_page]).to eq(1)
            expect(data[:total_count]).to eq(96)
          end
        end

        context 'no matched recipes found' do
          let(:resource_owner) { create(:user) }
          let(:token) { create(:access_token, resource_owner: resource_owner).token }
          let(:Authorization) { "Bearer #{token}" }
          let(:title) { 'my recipe 101' }

          run_test! do |response|
            data = JSON.parse(response.body).with_indifferent_access
            expect(data[:recipes].size).to eq(0)
            expect(data[:total_pages]).to eq(0)
            expect(data[:current_page]).to eq(1)
            expect(data[:total_count]).to eq(0)
          end
        end

        context 'matched recipes found with invalid time from' do
          let(:resource_owner) { create(:user) }
          let(:token) { create(:access_token, resource_owner: resource_owner).token }
          let(:Authorization) { "Bearer #{token}" }
          let(:title) { 'chicken soup' }
          let(:time_from) { 'xxx' }

          run_test! do |response|
            data = JSON.parse(response.body).with_indifferent_access
            expect(data[:recipes].size).to eq(10)
            expect(data[:total_pages]).to eq(10)
            expect(data[:current_page]).to eq(1)
            expect(data[:total_count]).to eq(96)
          end
        end

        context 'matched recipes found with invalid time to' do
          let(:resource_owner) { create(:user) }
          let(:token) { create(:access_token, resource_owner: resource_owner).token }
          let(:Authorization) { "Bearer #{token}" }
          let(:title) { 'chicken soup' }
          let(:time_to) { 'yyy' }

          run_test! do |response|
            data = JSON.parse(response.body).with_indifferent_access
            expect(data[:recipes].size).to eq(10)
            expect(data[:total_pages]).to eq(10)
            expect(data[:current_page]).to eq(1)
            expect(data[:total_count]).to eq(96)
          end
        end

        context 'matched recipes found with invalid time from & to' do
          let(:resource_owner) { create(:user) }
          let(:token) { create(:access_token, resource_owner: resource_owner).token }
          let(:Authorization) { "Bearer #{token}" }
          let(:title) { 'chicken soup' }
          let(:time_from) { 'xxx' }
          let(:time_to) { 'yyy' }

          run_test! do |response|
            data = JSON.parse(response.body).with_indifferent_access
            expect(data[:recipes].size).to eq(10)
            expect(data[:total_pages]).to eq(10)
            expect(data[:current_page]).to eq(1)
            expect(data[:total_count]).to eq(96)
          end
        end

        context 'matched recipes found with only time from' do
          let(:resource_owner) { create(:user) }
          let(:token) { create(:access_token, resource_owner: resource_owner).token }
          let(:Authorization) { "Bearer #{token}" }
          let(:title) { 'chicken soup' }
          let(:time_from) { 100 }

          run_test! do |response|
            data = JSON.parse(response.body).with_indifferent_access
            expect(data[:recipes].size).to eq(10)
            expect(data[:total_pages]).to eq(10)
            expect(data[:current_page]).to eq(1)
            expect(data[:total_count]).to eq(96)
          end
        end

        context 'matched recipes found with only time to' do
          let(:resource_owner) { create(:user) }
          let(:token) { create(:access_token, resource_owner: resource_owner).token }
          let(:Authorization) { "Bearer #{token}" }
          let(:title) { 'chicken soup' }
          let(:time_to) { 200 }

          run_test! do |response|
            data = JSON.parse(response.body).with_indifferent_access
            expect(data[:recipes].size).to eq(10)
            expect(data[:total_pages]).to eq(10)
            expect(data[:current_page]).to eq(1)
            expect(data[:total_count]).to eq(96)
          end
        end

        context 'matched recipes found with time from & to' do
          let(:resource_owner) { create(:user) }
          let(:token) { create(:access_token, resource_owner: resource_owner).token }
          let(:Authorization) { "Bearer #{token}" }
          let(:title) { 'chicken soup' }
          let(:time_from) { 100 }
          let(:time_to) { 150 }

          run_test! do |response|
            data = JSON.parse(response.body).with_indifferent_access
            expect(data[:recipes].size).to eq(10)
            expect(data[:total_pages]).to eq(10)
            expect(data[:current_page]).to eq(1)
            expect(data[:total_count]).to eq(96)
          end
        end

        context 'no matched recipes found with time from & to' do
          let(:resource_owner) { create(:user) }
          let(:token) { create(:access_token, resource_owner: resource_owner).token }
          let(:Authorization) { "Bearer #{token}" }
          let(:title) { 'chicken soup' }
          let(:time_from) { 80 }
          let(:time_to) { 100 }

          run_test! do |response|
            data = JSON.parse(response.body).with_indifferent_access
            expect(data[:recipes].size).to eq(0)
            expect(data[:total_pages]).to eq(0)
            expect(data[:current_page]).to eq(1)
            expect(data[:total_count]).to eq(0)
          end
        end

        context 'no matched recipes found with small time to' do
          let(:resource_owner) { create(:user) }
          let(:token) { create(:access_token, resource_owner: resource_owner).token }
          let(:Authorization) { "Bearer #{token}" }
          let(:title) { 'chicken soup' }
          let(:time_to) { 100 }

          run_test! do |response|
            data = JSON.parse(response.body).with_indifferent_access
            expect(data[:recipes].size).to eq(0)
            expect(data[:total_pages]).to eq(0)
            expect(data[:current_page]).to eq(1)
            expect(data[:total_count]).to eq(0)
          end
        end

        context 'no matched recipes found with big time from' do
          let(:resource_owner) { create(:user) }
          let(:token) { create(:access_token, resource_owner: resource_owner).token }
          let(:Authorization) { "Bearer #{token}" }
          let(:title) { 'chicken soup' }
          let(:time_from) { 200 }

          run_test! do |response|
            data = JSON.parse(response.body).with_indifferent_access
            expect(data[:recipes].size).to eq(0)
            expect(data[:total_pages]).to eq(0)
            expect(data[:current_page]).to eq(1)
            expect(data[:total_count]).to eq(0)
          end
        end

        context 'matched recipes found with difficulties' do
          let(:resource_owner) { create(:user) }
          let(:token) { create(:access_token, resource_owner: resource_owner).token }
          let(:Authorization) { "Bearer #{token}" }
          let(:title) { 'chicken soup' }
          let(:time_from) { 100 }
          let(:time_to) { 150 }
          let(:'difficulties[]') { [] }

          run_test! do |response|
            data = JSON.parse(response.body).with_indifferent_access
            expect(data[:recipes].size).to eq(10)
            expect(data[:total_pages]).to eq(10)
            expect(data[:current_page]).to eq(1)
            expect(data[:total_count]).to eq(96)
          end
        end

        context 'matched recipes found with difficulties' do
          let(:resource_owner) { create(:user) }
          let(:token) { create(:access_token, resource_owner: resource_owner).token }
          let(:Authorization) { "Bearer #{token}" }
          let(:title) { 'chicken soup' }
          let(:time_from) { 100 }
          let(:time_to) { 150 }
          let(:'difficulties[]') { ['easy'] }

          run_test! do |response|
            data = JSON.parse(response.body).with_indifferent_access
            expect(data[:recipes].size).to eq(10)
            expect(data[:total_pages]).to eq(10)
            expect(data[:current_page]).to eq(1)
            expect(data[:total_count]).to eq(96)
          end
        end

        context 'matched recipes found with difficulties' do
          let(:resource_owner) { create(:user) }
          let(:token) { create(:access_token, resource_owner: resource_owner).token }
          let(:Authorization) { "Bearer #{token}" }
          let(:title) { 'chicken soup' }
          let(:time_from) { 100 }
          let(:time_to) { 150 }
          let(:'difficulties[]') { %w[easy normal] }

          run_test! do |response|
            data = JSON.parse(response.body).with_indifferent_access
            expect(data[:recipes].size).to eq(10)
            expect(data[:total_pages]).to eq(10)
            expect(data[:current_page]).to eq(1)
            expect(data[:total_count]).to eq(96)
          end
        end

        context 'no matched recipes found with difficulties' do
          let(:resource_owner) { create(:user) }
          let(:token) { create(:access_token, resource_owner: resource_owner).token }
          let(:Authorization) { "Bearer #{token}" }
          let(:title) { 'chicken soup' }
          let(:time_from) { 100 }
          let(:time_to) { 150 }
          let(:'difficulties[]') { ['challenging'] }

          run_test! do |response|
            data = JSON.parse(response.body).with_indifferent_access
            expect(data[:recipes].size).to eq(0)
            expect(data[:total_pages]).to eq(0)
            expect(data[:current_page]).to eq(1)
            expect(data[:total_count]).to eq(0)
          end
        end
      end
    end
  end
end
