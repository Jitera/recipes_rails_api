class RecipeQueryService
  include ActiveModel::API
  include ActiveModel::Validations::Callbacks

  attr_accessor :title, :time, :difficulty, :min_sec, :max_sec

  validates :difficulty, inclusion: %w[easy normal challenging], allow_blank: true
  validates :time, format: { with: ConstantValidatable::TIME_DURATION_RANGE_VALIDATION_FORMAT }, allow_blank: true

  after_validation :set_time_values

  def initialize(title: nil, time: nil, difficulty: nil)
    @title = title
    @time = time
    @difficulty = difficulty
  end

  def execute
    q = Recipe.all
    q = q.title_has(@title) if @title.present?
    q = q.with_difficulty(Recipe.difficulties[@difficulty]) if @difficulty.present?
    q = q.time_within(@min_sec, @max_sec) if @min_sec.present?
    q
  end

  private

  def set_time_values
    if errors.empty? && time.present?
      m = time.match ConstantValidatable::TIME_DURATION_RANGE_VALIDATION_FORMAT
      @min_sec = (60* m[2].to_i + m[3].to_i + m[4].to_i*60 + m[5].to_i)*60
      @max_sec = (m[7].to_i*60 + m[8].to_i + m[9].to_i*60 + m[10].to_i)*60
    end
  end
end
