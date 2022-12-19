# frozen_string_literal: true

require 'swagger_helper'

describe 'Sign up user by email API' do
  path '/api/users_registrations' do
    post 'Sign up by email' do
      tags 'Sign up by email'
      consumes 'application/json'

      parameter name: :owner_fields, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string, example: 'user@jitera.com' },
          password: { type: :string, example: 'dummy_password' }
        }
      }

      response '200', 'user created' do
        user = User.find_by(email: 'user_1@jitera.com') || FactoryBot.create(:user, email: 'user_1@jitera.com')
        examples 'application/json' => {
          success: true,
          user: {
            id: user.id,
            email: user.email,
            created_at: '2021-12-02T16:55:50.696+09:00',
            updated_at: '2021-12-02T16:55:50.696+09:00'
          }
        }

        let(:owner_fields) do
          {
            email: 'user_1@jitera.co',
            password: 'dummy_password'
          }
        end

        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['success']).to be_truthy
        end
      end

      response '422', 'Cannot register' do
        examples 'application/json' => {
          error_message: I18n.t('errors.email_login.failed_to_sign_up')
        }

        let(:owner_fields) do
          {
            email: 'invalid_email',
            password: 'dummy_password'
          }
        end

        run_test! do |response|
          data = JSON.parse(response.body)

          expect(data['error_message']).to eq(I18n.t('errors.email_login.failed_to_sign_up'))
        end
      end
    end
  end
end
