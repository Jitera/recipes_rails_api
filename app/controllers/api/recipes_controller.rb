class Api::RecipesController < Api::BaseController
  # jitera-anchor-dont-touch: before_action_filter
  before_action :doorkeeper_authorize!, only: %w[index show update destroy search]
  before_action :current_user_authenticate, only: %w[index show update destroy search]

  # TODO: anyone can update/destroy recipes even if they are not the owner of it
  # one create a new recipe that is from another user, just by passing any user_id which does not make any sense
  # naming convention for param object in case of create/update/destroy should be in singular form rather than plural, ex: :recipe, not :recipes
  # Same thing with categories/ingredients

  # jitera-anchor-dont-touch: actions
  def destroy
    @recipe = Recipe.find_by(id: params[:id])
    @error_message = true unless @recipe&.destroy
  end

  def update
    @recipe = Recipe.find_by(id: params[:id])

    request = {}
    request.merge!('title' => params.dig(:recipes, :title))
    request.merge!('descriptions' => params.dig(:recipes, :descriptions))
    request.merge!('time' => params.dig(:recipes, :time))
    request.merge!('difficulty' => params.dig(:recipes, :difficulty))
    request.merge!('category_id' => params.dig(:recipes, :category_id))
    request.merge!('user_id' => params.dig(:recipes, :user_id))

    @error_object = @recipe.errors.messages unless @recipe.update(request)
  end

  def show
    @recipe = Recipe.find_by(id: params[:id])
    @error_message = true if @recipe.blank?
  end

  def create
    @recipe = Recipe.new

    request = {}
    request.merge!('title' => params.dig(:recipes, :title))
    request.merge!('descriptions' => params.dig(:recipes, :descriptions))
    request.merge!('time' => params.dig(:recipes, :time))
    request.merge!('difficulty' => params.dig(:recipes, :difficulty))
    request.merge!('category_id' => params.dig(:recipes, :category_id))
    request.merge!('user_id' => params.dig(:recipes, :user_id))

    @recipe.assign_attributes(request)
    @error_object = @recipe.errors.messages unless @recipe.save
  end

  def index
    request = {}

    # TODO: this is unnecessary
    request.merge!('title' => params.dig(:recipes, :title))
    request.merge!('descriptions' => params.dig(:recipes, :descriptions))
    request.merge!('time' => params.dig(:recipes, :time))
    request.merge!('difficulty' => params.dig(:recipes, :difficulty))
    request.merge!('category_id' => params.dig(:recipes, :category_id))
    request.merge!('user_id' => params.dig(:recipes, :user_id))

    @recipes = Recipe.all
  end

  def search
    time_from = params[:time_from].to_i
    time_to = params[:time_to].to_i
    difficulties = params[:difficulties]

    @recipes = Recipe.all
    @recipes = @recipes.where('MATCH (title) AGAINST (? IN BOOLEAN MODE)', params[:title]) if params[:title].present?
    @recipes = @recipes.where('time >= ?', time_from) if time_from > 0
    @recipes = @recipes.where('time <= ?', time_to) if time_to > 0

    if difficulties.is_a? Array
      difficulties = difficulties.reject(&:blank?)
      @recipes = @recipes.where(difficulty: difficulties) if difficulties.size > 0
    end

    @recipes = @recipes.page(page).per(per_page)
  end
end
