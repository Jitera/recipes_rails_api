module Api
  class BaseController < ActionController::API
    include OauthTokensConcern
    include Pundit # TODO: Pundit is included but never been used, so no policy have been enforced even though they were defined in app/policies

    # =======End include module======

    rescue_from ActiveRecord::RecordNotFound, with: :base_render_record_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :base_render_unprocessable_entity
    rescue_from Exceptions::AuthenticationError, with: :base_render_authentication_error
    rescue_from ActiveRecord::RecordNotUnique, with: :base_render_record_not_unique
    rescue_from Pundit::NotAuthorizedError, with: :base_render_unauthorized_error

    # TODO: this was defined but never really been used anywhere
    def serialize(resource, option = {})
      ActiveModelSerializers::SerializableResource.new(
        resource,
        option
      ).serializable_hash.as_json
    end

    def error_response(resource, error)
      {
        # TODO: should have error_code to indicate what kind of error is returning to client
        success: false,
        full_messages: resource&.errors&.full_messages,
        errors: resource&.errors,
        error_message: error.message,
        backtrace: error.backtrace # TODO: backtrace only on development
      }
    end

    def page
      params[:page] ||= 1
    end

    def per_page
      params[:per_page] ||= 10
    end

    private

    # TODO: use error_response that defined above to render consistency error response data format

    def base_render_record_not_found(exception)
      render json: { message: exception.message }, status: :not_found
    end

    def base_render_unprocessable_entity(exception)
      render json: { message: exception.record.errors.full_messages }, status: :unprocessable_entity
    end

    def base_render_authentication_error(exception)
      render json: { message: exception.message }, status: :not_found
    end

    def base_render_unauthorized_error(_exception)
      render json: { message: I18n.t('errors.unauthorized_error') }, status: :unauthorized
    end

    def base_render_record_not_unique
      render json: { message: I18n.t('errors.record_not_uniq_error') }, status: :forbidden
    end
  end
end
