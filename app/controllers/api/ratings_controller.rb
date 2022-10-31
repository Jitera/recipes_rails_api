class Api::RatingsController < Api::BaseController
  before_action :doorkeeper_authorize!, only: %w[index show update destroy]
  before_action :current_user_authenticate, only: %w[index show update destroy]
  before_action :recipe

  def index
    @recipe.ratings
  end

  def create
    @rating = @recipe.ratings.build(rating_params.merge({ user: current_user }))
    if @rating.valid?
      @rating = @recipe.create_or_update_user_rating(user: current_user, rating: @rating.rating).reload
    else
      @error_object = @rating.errors.messages
    end
  end

  private

  def recipe
    @recipe = Recipe.find params[:recipe_id]
  end

  def rating_params
    params.require(:rating).permit(:rating)
  end
end
