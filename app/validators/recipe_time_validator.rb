class RecipeTimeValidator < ActiveModel::Validator
  def validate(record)
    return unless record.time

    arr_times = record.time.split(/\s+-\s+/, 2).map do |time|
      time.scan(ConstantValidatable::RECIPE_TIME_FORMAT)
    end

    record.errors.add(:time, I18n.t('activerecord.errors.models.recipe.attributes.time.invalid_format', format_time: '1 min - 10 mins')) \
      if arr_times.any?(&:empty?)

    record.errors.add(:time, I18n.t('activerecord.errors.models.recipe.attributes.time.invalid_value')) \
      if record.from_time.to_i >= record.to_time.to_i
  end
end
