class Api::RecipesController < Api::BaseController
  # jitera-anchor-dont-touch: before_action_filter
  before_action :doorkeeper_authorize!, only: %w[index show update destroy ratings rate]
  before_action :current_user_authenticate, only: %w[index show update destroy ratings rate]

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
    @recipe = Recipe.includes(:ingredients).find_by(id: params[:id])
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
    @recipes = Recipe.includes(:ingredients).all
  end

  def search
    @recipes = Recipe.search(search_params)
    @error_message = I18n.t('errors.messages.search_not_found') if @recipe.blank?
  end

  def ratings
    @ratings = Rating.where(recipe_id: params[:id])
    @error_message = true if @ratings.blank?
  end

  def rate
    @rating = Rating.new

    request = {}
    request.merge!('points' => params.dig(:ratings, :points))
    request.merge!('comments' => params.dig(:ratings, :comments))
    request.merge!('user_id' => params.dig(:ratings, :user_id))
    request.merge!('recipe_id' => params[:id])

    @rating.assign_attributes(request)
    @error_object = @rating.errors.messages unless @rating.save
  end

  private

  def search_params
    params.permit(:title, :time_start, :time_end, :difficulty)
  end
end
