class Ingredient < ApplicationRecord
  include ConstantValidatable

  # jitera-anchor-dont-touch: relations

  belongs_to :recipe

  # jitera-anchor-dont-touch: enum
  enum unit: %w[cup teaspoons gram kilogram], _suffix: true

  # jitera-anchor-dont-touch: file

  # jitera-anchor-dont-touch: validation

  validates :unit, presence: true

  validates :amount,
            numericality: { greater_than: 0.0, less_than: 3.402823466e+38, message: I18n.t('errors.messages.out_of_range_error') }, presence: true

  # jitera-anchor-dont-touch: reset_password

  class << self
    def weight_converter(options = {})
      return if options.blank?

      unit_from = options.dig(:unit_from)
      unit_to = options.dig(:unit_to)
      amount_from = options.dig(:amount_from)

      return if unit_from.nil? || unit_to.nil? || amount_from.nil?

      case unit_from.to_i
      when Ingredient.units[:kilogram]
        amount_to = amount_from.to_i * 1_000 # Kilogram to Gram
      when Ingredient.units[:gram]
        amount_to = amount_from.to_f / 1_000 # Gram to Kilogram
      else
        amount_to = amount_from.to_i # Doesn't support with [cup teaspoons]
      end

      {
        unit_from: unit_from, unit_to: unit_to,
        amount_from: amount_from, amount_to: amount_to
      }
    end
  end
end
