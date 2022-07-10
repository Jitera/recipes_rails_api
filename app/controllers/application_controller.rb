class ApplicationController < ActionController::Base
  include ActionController::Cookies
  include Pundit::Authorization

  # basic_auth
end
