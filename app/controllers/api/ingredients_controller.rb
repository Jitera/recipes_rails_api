class Api::IngredientsController < Api::BaseController
  # jitera-anchor-dont-touch: before_action_filter
  before_action :set_ingredient, only: %w[destroy update show convert_weight]
  around_action :with_transaction, only: %w[create update destroy]

  # jitera-anchor-dont-touch: actions
  def destroy
    @ingredient.destroy
    render json: json_with_success(message: I18n.t('ingredients.destroy_successfully')), status: :ok
  end

  def update
    @ingredient.update!(ingredient_params)
    render json: json_with_success(message: I18n.t('ingredients.update_successfully'),
                                   data: @ingredient,
                                   options: { serialize: { serializer: IngredientSerializer } }), status: :ok
  end

  def show
    render json: json_with_success(data: @ingredient, options: { serialize: { serializer: IngredientSerializer } })
  end

  def create
    @ingredient = Ingredient.create!(ingredient_params)
    render json: json_with_success(message: I18n.t('ingredients.create_successfully'),
                                   data: @ingredient,
                                   options: { serialize: { serializer: IngredientSerializer } }), status: :created
  end

  def index
    ingredients = ::Ingredients::GatherIngredientsService.call(Ingredient.all.includes(:recipe), params)
    ingredients = ingredients.fetch_page(fetch_params)
    return render json: json_with_success(data: ingredients, options: { serialize: { each_serializer: IngredientSerializer } }) \
      if without_paging

    render json: json_with_pagination(data: ingredients, custom_serializer: IngredientSerializer)
  end

  def convert_weight
    result = ::Ingredients::ConvertWeightService.call(@ingredient.amount, @ingredient.unit)
    return render json: json_with_error(message: I18n.t('errors.invalid_unit_to_convert')), status: :bad_request \
      if result.negative?

    unit = @ingredient.gram_unit? ? 'kilogram' : 'gram'
    render json: json_with_success_without_serialize(message: I18n.t('ingredients.convert_weight_successfully', unit: unit), data: result), status: :ok
  end

  private

  def set_ingredient
    @ingredient = Ingredient.find_by(id: params[:id] || params[:ingredient_id])
    render json: json_with_error(message: I18n.t('ingredients.not_found')), status: :not_found unless @ingredient
  end

  def ingredient_params
    params.require(:ingredient).permit(:unit, :amount, :recipe_id)
  end
end
