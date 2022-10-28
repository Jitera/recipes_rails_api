require 'sidekiq/web'

module ActionDispatch
  module Routing
    class Mapper
      def draw(routes_name)
        routes_path = Rails.root.join('config', 'routes', (@scope[:shallow_prefix]).to_s, "#{routes_name}.rb")

        instance_eval(File.read(routes_path))
      end
    end
  end
end

# rubocop:disable Metrics/BlockLength
Rails.application.routes.draw do
  # use_doorkeeper
  use_doorkeeper do
    skip_controllers :authorizations, :applications, :authorized_applications
  end
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  get '/health' => 'pages#health_check'

  namespace :api do
    put '/users_passwords', to: 'users_passwords#put_users_passwords'
    resources :users_registrations, only: [:create] do
    end

    resources :users_verify_reset_password_requests, only: [:create] do
    end

    resources :users_reset_password_requests, only: [:create] do
    end

    resources :users_sessions, only: [:create] do
    end

    resources :ingredients, only: %i[index create show update destroy] do
    end

    resources :categories, only: %i[index create show update destroy] do
    end

    resources :recipes, only: %i[index create show update destroy] do
      resources :ratings, only: %i[index create]
    end

    get '/converters/convert', to: 'converters#convert'
  end

  # jitera-anchor-dont-touch: webhooks

  namespace :dashboard do
    # TODO: customizable table name
  end

  unless Rails.env.development?
    Sidekiq::Web.use Rack::Auth::Basic do |username, password|
      admin_username = ENV.fetch('SIDEKIQ_DASHBOARD_USERNAME', nil)
      admin_password = ENV.fetch('SIDEKIQ_DASHBOARD_PASSWORD', nil)
      ActiveSupport::SecurityUtils.secure_compare(
        ::Digest::SHA256.hexdigest(username),
        ::Digest::SHA256.hexdigest(admin_username)
      ) && ActiveSupport::SecurityUtils.secure_compare(
        ::Digest::SHA256.hexdigest(password),
        ::Digest::SHA256.hexdigest(admin_password)
      )
    end
  end
  mount Sidekiq::Web => '/sidekiq'
end
# rubocop:enable Metrics/BlockLength
