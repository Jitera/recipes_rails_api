class Api::RecipesController < Api::BaseController
  # jitera-anchor-dont-touch: before_action_filter
  before_action :doorkeeper_authorize!, only: %w[index show update destroy vote unvote]
  before_action :current_user_authenticate, only: %w[index show update destroy vote unvote]
  before_action :set_recipe, only: %w[show update destroy vote unvote]
  before_action :check_ability_vote, only: %w[vote unvote]
  before_action :check_owner, only: %w[update destroy]
  around_action :with_transaction, only: %w[create update destroy vote unvote]

  # jitera-anchor-dont-touch: actions
  def destroy
    render json: json_with_success(message: I18n.t('recipes.destroy_successfully')), status: :ok if @recipe&.destroy
  end

  def update
    @recipe.update!(recipe_params)
    render json: json_with_success(message: I18n.t('recipes.update_successfully'),
                                   data: @recipe,
                                   options: { serialize: { serializer: RecipeSerializer } }), status: :ok
  end

  def show
    render json: json_with_success(data: @recipe, options: { serialize: { serializer: RecipeSerializer } })
  end

  def create
    @recipe = current_user.recipes.create!(recipe_params)
    render json: json_with_success(message: I18n.t('recipes.create_successfully'),
                                   data: @recipe,
                                   options: { serialize: { serializer: RecipeSerializer } }), status: :created
  end

  def index
    recipes = ::Recipes::GatherRecipesService.call(Recipe.all.includes(:ingredients, :votes), params)
    recipes = recipes.fetch_page(fetch_params)
    return render json: json_with_success(data: recipes, options: { serialize: { each_serializer: RecipeSerializer } }) \
      if without_paging

    render json: json_with_pagination(data: recipes, custom_serializer: RecipeSerializer)
  end

  def vote
    vote = Vote.create!(user_id: current_user.id, recipe_id: @recipe.id)
    render json: json_with_success(message: I18n.t('recipes.vote_successfully'),
                                   data: vote,
                                   options: { serialize: { serializer: Votes::DetailVoterInfoSerializer } }), status: :created
  end

  def unvote
    vote = Vote.find_by(user_id: current_user.id, recipe_id: @recipe.id)
    render json: json_with_success(message: I18n.t('recipes.unvote_successfully')), status: :ok if vote&.destroy
  end

  private

  def set_recipe
    @recipe = Recipe.find_by(id: params[:id] || params[:recipe_id])
    render json: json_with_error(message: I18n.t('recipes.not_found')), status: :not_found unless @recipe
  end

  def check_ability_vote
    render json: json_with_error(message: I18n.t('recipes.can_not_vote')), status: :bad_request \
      if current_user == @recipe.user
  end

  def check_owner
    render json: json_with_error(message: I18n.t('recipes.not_owner')), status: :bad_request \
      if current_user != @recipe.user
  end

  def recipe_params
    params.require(:recipe).permit(:title, :descriptions, :time, :difficulty, :category_id)
  end
end
