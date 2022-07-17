class Api::UnitsController < Api::BaseController
  # jitera-anchor-dont-touch: before_action_filter
  before_action :doorkeeper_authorize!, only: %w[convert]
  before_action :current_user_authenticate, only: %w[convert]

  # jitera-anchor-dont-touch: actions

  def convert
    @from = params[:from]
    @to = params[:to]
    @amount = params[:amount].to_f
    @converted = Converter.convert(@from, @to, @amount)
  end
end
