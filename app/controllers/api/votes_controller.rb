class Api::VotesController < Api::BaseController
  before_action :doorkeeper_authorize!
  before_action :current_user_authenticate
  before_action :set_recipe
  before_action :check_owner

  def index
    votes = @recipe.votes
    votes = votes.fetch_page(fetch_params)
    return render json: json_with_success(data: votes, options: { serialize: { each_serializer: Votes::DetailVoterInfoSerializer } }) \
      if without_paging

    render json: json_with_pagination(data: votes, custom_serializer: Votes::DetailVoterInfoSerializer)
  end

  private

  def set_recipe
    @recipe = Recipe.find_by(id: params[:recipe_id])
    render json: json_with_error(message: I18n.t('recipes.not_found')), status: :not_found unless @recipe
  end

  def check_owner
    render json: json_with_error(message: I18n.t('recipes.not_owner')), status: :bad_request \
      if current_user != @recipe.user
  end
end
