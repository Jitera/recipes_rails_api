class Api::RecipesController < Api::BaseController
  # jitera-anchor-dont-touch: before_action_filter
  before_action :doorkeeper_authorize!, only: %w[index show update destroy rate]
  before_action :current_user_authenticate, only: %w[index show update destroy rate]

  # jitera-anchor-dont-touch: actions
  def destroy
    @recipe = recipe
  end

  def update
    @recipe = recipe

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
    @recipe = recipe
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

    request.merge!('title' => params[:title])
    request.merge!('descriptions' => params[:descriptions])
    request.merge!('time' => params[:time])
    request.merge!('difficulty' => params[:difficulty])
    request.merge!('category_id' => params[:category_id])
    request.merge!('user_id' => params[:user_id])

    service = ::Recipes::List.new(request.with_indifferent_access)
    service.call
    @error_object = service.error_messages unless service.success?
    @recipes = service.data
  end

  def rate
    service = ::Recipes::Rate.new(recipe, rate_params)
    service.call
    @error_object = service.error_messages unless service.success?
    @data = service.data
  end

  def rate_params
    @rate_params ||= params.permit(:point).merge(user_id: current_user.id)
  end

  def recipe
    @recipe ||= Recipe.find(params[:id])
  end
end
