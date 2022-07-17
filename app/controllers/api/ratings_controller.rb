class Api::RatingsController < Api::BaseController
  # jitera-anchor-dont-touch: before_action_filter
  before_action :doorkeeper_authorize!, only: %w[index show update destroy search]
  before_action :current_user_authenticate, only: %w[index show update destroy search]

  before_action :find_recipe
  before_action :find_rating, only: [:show, :update, :destroy]

  # jitera-anchor-dont-touch: actions

  def show
  end

  def create
    @rating = Rating.new
    attrs = {}
    attrs.merge!(score: params.dig(:rating, :score))
    attrs.merge!(user_id: current_user.id)
    attrs.merge!(recipe_id: @recipe.id)

    @rating.assign_attributes(attrs)

    @rating.save!
  end

  def destroy
    authorize @rating
    @rating.destroy!
  end

  def update
    authorize @rating
    attrs = {}
    attrs.merge!(score: params.dig(:rating, :score))
    @rating.update!(attrs)
  end

  def index
    @ratings = @recipe.ratings.includes(:user).page(page).per(per_page)
  end

  private

  def find_recipe
    @recipe = Recipe.find(params[:recipe_id])
  end

  def find_rating
    @rating = Rating.find(params[:id])
  end
end
