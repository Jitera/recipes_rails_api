# frozen_string_literal: true

module Api
  class UsersRegistrationsController < Api::BaseController
    def create
      existed_user = User.find_by(email: create_param[:email])
      if existed_user
        @error_message = I18n.t('errors.email_login.failed_to_sign_up')
        render status: 422
      else
        user = User.new(email: create_param[:email], password: create_param[:password])

        if user.save
          @success = true
          @user = user
        else
          @error_message = I18n.t('errors.email_login.failed_to_sign_up')
          render status: 422
        end
      end
    end

    private

    def create_param
      params.permit(:email, :password)
    end
  end
end
