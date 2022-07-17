require 'swagger_helper'

RSpec.describe 'api/recipes/{recipe_id}/ratings', type: :request do
  before(:all) do
    recipe1 = create(:recipe)
    recipe2 = create(:recipe)
    (0..95).each { create(:rating, recipe_id: recipe1.id) }
    (0..80).each { create(:rating, recipe_id: recipe2.id) }
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

  after(:all) do
    Recipe.destroy_all
  end

  # jitera-hook-for-rswag-example

  path '/api/recipes/{recipe_id}/ratings' do
    get 'get ratings of a recipe' do
      tags 'ratings'
      consumes 'application/json'
      security [bearerAuth: []]

      parameter name: :recipe_id, in: :path, type: :number, required: true
      parameter name: :per_page, in: :query, type: :number, required: false
      parameter name: :page, in: :query, type: :number, required: false

      response '404', 'not found' do
        schema type: :object,
               properties: {
                 message: {
                   type: :string
                 }
               }

        context 'recipe not found' do
          let(:resource_owner) { create(:user) }
          let(:token) { create(:access_token, resource_owner: resource_owner).token }
          let(:Authorization) { "Bearer #{token}" }
          let(:recipe_id) { 9999 }

          run_test!
        end
      end

      response '200', 'ratings' do
        schema type: :object,
               properties: {
                 ratings: {
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
                       score: {
                         type: :number
                       },
                       user: {
                         type: :object,
                         properties: {
                           id: {
                             type: :number
                           },
                           email: {
                             type: :string
                           },
                         }
                       }
                     }
                   }
                 }
               }

        context 'have ratings' do
          let(:resource_owner) { create(:user) }
          let(:token) { create(:access_token, resource_owner: resource_owner).token }
          let(:Authorization) { "Bearer #{token}" }
          let(:recipe_id) { Recipe.first.id }

          run_test! do |response|
            data = JSON.parse(response.body).with_indifferent_access
            expect(data[:ratings].size).to eq(10)
            expect(data[:total_pages]).to eq(10)
            expect(data[:current_page]).to eq(1)
            expect(data[:total_count]).to eq(96)
          end
        end

        context 'have ratings more than 1 page' do
          let(:resource_owner) { create(:user) }
          let(:token) { create(:access_token, resource_owner: resource_owner).token }
          let(:Authorization) { "Bearer #{token}" }
          let(:recipe_id) { Recipe.first.id }
          let(:page) { 3 }

          run_test! do |response|
            data = JSON.parse(response.body).with_indifferent_access
            expect(data[:ratings].size).to eq(10)
            expect(data[:total_pages]).to eq(10)
            expect(data[:current_page]).to eq(3)
            expect(data[:total_count]).to eq(96)
          end
        end
      end
    end
  end

  path '/api/recipes/{recipe_id}/ratings/{id}' do
    get 'show a rating of a recipe' do
      tags 'ratings'
      consumes 'application/json'
      security [bearerAuth: []]

      parameter name: :recipe_id, in: :path, type: :number, required: true
      parameter name: :id, in: :path, type: :number, required: true

      response '404', 'not found' do
        schema type: :object,
               properties: {
                 message: {
                   type: :string
                 }
               }

        context 'rating not found' do
          let(:resource_owner) { create(:user) }
          let(:token) { create(:access_token, resource_owner: resource_owner).token }
          let(:Authorization) { "Bearer #{token}" }
          let(:recipe_id) { Recipe.first.id }
          let(:id) { 9999 }
          run_test!
        end

        context 'recipe not found' do
          let(:resource_owner) { create(:user) }
          let(:token) { create(:access_token, resource_owner: resource_owner).token }
          let(:Authorization) { "Bearer #{token}" }
          let(:recipe_id) { 9999 }
          let(:id) { Rating.first.id }
          run_test!
        end
      end

      response '200', 'rating' do
        schema type: :object,
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
                 score: {
                   type: :number
                 },
                 user: {
                   type: :object,
                   properties: {
                     id: {
                       type: :number
                     },
                     email: {
                       type: :string
                     },
                   }
                 }
               }

        context 'rating found' do
          let(:resource_owner) { create(:user) }
          let(:token) { create(:access_token, resource_owner: resource_owner).token }
          let(:Authorization) { "Bearer #{token}" }
          let(:recipe_id) { Rating.first.recipe.id }
          let(:id) { Rating.first.id }

          run_test! do |response|
            data = JSON.parse(response.body).with_indifferent_access
            expect(data[:rating][:id]).to eq(id)
          end
        end
      end
    end
  end

  path '/api/recipes/{recipe_id}/ratings/{id}' do
    patch 'update a rating of a recipe' do
      tags 'ratings'
      consumes 'application/json'
      security [bearerAuth: []]

      parameter name: :recipe_id, in: :path, type: :number, required: true
      parameter name: :id, in: :path, type: :number, required: true
      parameter name: :rating, in: :body, type: :object, schema: {
        type: :object,
        properties: {
          score: {
            type: :number
          }
        }
      }

      response '404', 'not found' do
        schema type: :object,
               properties: {
                 message: {
                   type: :string
                 }
               }

        context 'rating not found' do
          let(:resource_owner) { create(:user) }
          let(:token) { create(:access_token, resource_owner: resource_owner).token }
          let(:Authorization) { "Bearer #{token}" }
          let(:recipe_id) { Recipe.first.id }
          let(:id) { 9999 }
          let(:rating) {}
          run_test!
        end

        context 'recipe not found' do
          let(:resource_owner) { create(:user) }
          let(:token) { create(:access_token, resource_owner: resource_owner).token }
          let(:Authorization) { "Bearer #{token}" }
          let(:recipe_id) { 9999 }
          let(:id) { Rating.first.id }
          let(:rating) {}
          run_test!
        end
      end

      response '401', 'rating' do
        schema type: :object,
               properties: {
                 message: {
                   type: :string
                 }
               }

        context 'update rating unauthorized' do
          let(:resource_owner) { create(:user) }
          let(:token) { create(:access_token, resource_owner: resource_owner).token }
          let(:Authorization) { "Bearer #{token}" }
          let(:recipe_id) { Rating.first.recipe.id }
          let(:id) { Rating.first.id }
          let(:rating) { { rating: {score: 2} } }

          run_test!
        end
      end

      response '422', 'rating' do
        schema type: :object,
               properties: {
                 message: {
                   type: :array,
                   items: {
                     type: :string
                   }
                 }
               }

        context 'update rating unprocessable entity score negative' do
          let(:resource_owner) { Rating.first.user }
          let(:token) { create(:access_token, resource_owner: resource_owner).token }
          let(:Authorization) { "Bearer #{token}" }
          let(:recipe_id) { Rating.first.recipe.id }
          let(:id) { Rating.first.id }
          let(:rating) { { rating: {score: -1} } }

          run_test!
        end

        context 'update rating unprocessable entity score too big' do
          let(:resource_owner) { Rating.first.user }
          let(:token) { create(:access_token, resource_owner: resource_owner).token }
          let(:Authorization) { "Bearer #{token}" }
          let(:recipe_id) { Rating.first.recipe.id }
          let(:id) { Rating.first.id }
          let(:rating) { { rating: {score: 12} } }

          run_test!
        end
      end

      response '200', 'rating' do
        schema type: :object,
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
                 score: {
                   type: :number
                 },
                 user: {
                   type: :object,
                   properties: {
                     id: {
                       type: :number
                     },
                     email: {
                       type: :string
                     },
                   }
                 }
               }

        context 'update rating success' do
          let(:resource_owner) { Rating.first.user }
          let(:token) { create(:access_token, resource_owner: resource_owner).token }
          let(:Authorization) { "Bearer #{token}" }
          let(:recipe_id) { Rating.first.recipe.id }
          let(:id) { Rating.first.id }
          let(:rating) { { rating: {score: 2} } }

          run_test! do |response|
            data = JSON.parse(response.body).with_indifferent_access
            expect(data[:rating][:id]).to eq(id)
            expect(data[:rating][:score]).to eq(2)
          end
        end
      end
    end
  end

  path '/api/recipes/{recipe_id}/ratings/{id}' do
    delete 'delete a rating of a recipe' do
      tags 'ratings'
      consumes 'application/json'
      security [bearerAuth: []]

      parameter name: :recipe_id, in: :path, type: :number, required: true
      parameter name: :id, in: :path, type: :number, required: true

      response '404', 'not found' do
        schema type: :object,
               properties: {
                 message: {
                   type: :string
                 }
               }

        context 'rating not found' do
          let(:resource_owner) { create(:user) }
          let(:token) { create(:access_token, resource_owner: resource_owner).token }
          let(:Authorization) { "Bearer #{token}" }
          let(:recipe_id) { Recipe.first.id }
          let(:id) { 9999 }
          run_test!
        end

        context 'recipe not found' do
          let(:resource_owner) { create(:user) }
          let(:token) { create(:access_token, resource_owner: resource_owner).token }
          let(:Authorization) { "Bearer #{token}" }
          let(:recipe_id) { 9999 }
          let(:id) { Rating.first.id }
          run_test!
        end
      end

      response '401', 'rating' do
        schema type: :object,
               properties: {
                 message: {
                   type: :string
                 }
               }

        context 'destroy rating unauthorized' do
          let(:resource_owner) { create(:user) }
          let(:token) { create(:access_token, resource_owner: resource_owner).token }
          let(:Authorization) { "Bearer #{token}" }
          let(:recipe_id) { Rating.first.recipe.id }
          let(:id) { Rating.first.id }
          run_test!
        end
      end

      response '200', 'rating' do
        schema type: :object,
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
                 score: {
                   type: :number
                 },
                 user: {
                   type: :object,
                   properties: {
                     id: {
                       type: :number
                     },
                     email: {
                       type: :string
                     },
                   }
                 }
               }

        context 'destroy rating success' do
          let(:resource_owner) { Rating.first.user }
          let(:token) { create(:access_token, resource_owner: resource_owner).token }
          let(:Authorization) { "Bearer #{token}" }
          let(:recipe_id) { Rating.first.recipe.id }
          let(:id) { Rating.first.id }

          run_test! do |response|
            data = JSON.parse(response.body).with_indifferent_access
            expect(data[:rating][:id]).to eq(id)
            expect(Rating.find_by(id: id)).to eq(nil)
          end
        end
      end
    end
  end

  path '/api/recipes/{recipe_id}/ratings' do
    post 'create a rating of a recipe' do
      tags 'ratings'
      consumes 'application/json'
      security [bearerAuth: []]

      parameter name: :recipe_id, in: :path, type: :number, required: true
      parameter name: :rating, in: :body, type: :object, schema: {
        type: :object,
        properties: {
          score: {
            type: :number
          }
        }
      }

      response '404', 'not found' do
        schema type: :object,
               properties: {
                 message: {
                   type: :string
                 }
               }

        context 'recipe not found' do
          let(:resource_owner) { create(:user) }
          let(:token) { create(:access_token, resource_owner: resource_owner).token }
          let(:Authorization) { "Bearer #{token}" }
          let(:recipe_id) { 9999 }
          let(:rating) {}
          run_test!
        end
      end

      response '422', 'rating' do
        schema type: :object,
               properties: {
                 message: {
                   type: :array,
                   items: {
                     type: :string
                   }
                 }
               }

        context 'create rating unprocessable entity score nil' do
          let(:resource_owner) { create(:user) }
          let(:token) { create(:access_token, resource_owner: resource_owner).token }
          let(:Authorization) { "Bearer #{token}" }
          let(:recipe_id) { Recipe.first.id }
          let(:rating) { { rating: {score: nil} } }

          run_test!
        end

        context 'create rating unprocessable entity score negative' do
          let(:resource_owner) { create(:user) }
          let(:token) { create(:access_token, resource_owner: resource_owner).token }
          let(:Authorization) { "Bearer #{token}" }
          let(:recipe_id) { Recipe.first.id }
          let(:rating) { { rating: {score: -1} } }

          run_test!
        end

        context 'create rating unprocessable entity score too big' do
          let(:resource_owner) { Rating.first.user }
          let(:token) { create(:access_token, resource_owner: resource_owner).token }
          let(:Authorization) { "Bearer #{token}" }
          let(:recipe_id) { Recipe.first.id }
          let(:rating) { { rating: {score: 12} } }

          run_test!
        end
      end

      response '200', 'rating' do
        schema type: :object,
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
                 score: {
                   type: :number
                 },
                 user: {
                   type: :object,
                   properties: {
                     id: {
                       type: :number
                     },
                     email: {
                       type: :string
                     },
                   }
                 }
               }

        context 'create rating success' do
          let(:resource_owner) { create(:user) }
          let(:token) { create(:access_token, resource_owner: resource_owner).token }
          let(:Authorization) { "Bearer #{token}" }
          let(:recipe_id) { Recipe.first.id }
          let(:rating) { { rating: {score: 3} } }

          run_test! do |response|
            data = JSON.parse(response.body).with_indifferent_access
            expect(data[:rating][:score]).to eq(3)
            expect(data[:rating][:user][:id]).to eq(resource_owner.id)
          end
        end
      end
    end
  end
end
