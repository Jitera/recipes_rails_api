class Ingredient < ApplicationRecord
  include ConstantValidatable

  GRAM_CONVERTER = {
    gram: 1.0,
    kilogram: 1000.0,
    cup: 128.0,
    teaspoons: 4.9289
  }.with_indifferent_access

  UNIT_CONVERTER_FROM_GRAM = {
    gram: 1.0,
    kilogram: 1 / 1000.0,
    cup: 1 / 128.0,
    teaspoons: 1 / 4.9289
  }.with_indifferent_access

  # jitera-anchor-dont-touch: relations

  belongs_to :recipe

  # jitera-anchor-dont-touch: enum
  enum unit: %w[cup teaspoons gram kilogram], _suffix: true

  # jitera-anchor-dont-touch: file

  # jitera-anchor-dont-touch: validation

  validates :unit, presence: true

  validates :amount,
            numericality: { greater_than: 0.0, less_than: 3.402823466e+38, message: I18n.t('errors.out_of_range_error') }, presence: true

  # jitera-anchor-dont-touch: reset_password

  class << self
  end
end
