class Api::CategoriesController < Api::BaseController
  # jitera-anchor-dont-touch: before_action_filter
  before_action :set_category, only: %w[destroy update show]
  around_action :with_transaction, only: %w[create update destroy]

  # jitera-anchor-dont-touch: actions
  def destroy
    @category.destroy
    render json: json_with_success(message: I18n.t('categories.destroy_successfully')), status: :ok
  end

  def update
    @category.update!(category_params)
    render json: json_with_success(message: I18n.t('categories.update_successfully'),
                                   data: @category,
                                   options: { serialize: { serializer: CategorySerializer } }), status: :ok
  end

  def show
    render json: json_with_success(data: @category, options: { serialize: { serializer: CategorySerializer } })
  end

  def create
    @category = Category.create!(category_params)
    render json: json_with_success(message: I18n.t('categories.create_successfully'),
                                   data: @category,
                                   options: { serialize: { serializer: CategorySerializer } }), status: :created
  end

  def index
    categories = ::Categories::GatherCategoriesService.call(Category.all.includes(recipes: %i[ingredients votes]), params)
    categories = categories.fetch_page(fetch_params)
    return render json: json_with_success(data: categories, options: { serialize: { each_serializer: CategorySerializer } }) \
      if without_paging

    render json: json_with_pagination(data: categories, custom_serializer: CategorySerializer)
  end

  private

  def set_category
    @category = Category.find_by(id: params[:id])
    render json: json_with_error(message: I18n.t('categories.not_found')), status: :not_found unless @category
  end

  def category_params
    params.require(:category).permit(:description)
  end
end
