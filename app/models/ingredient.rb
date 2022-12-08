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
            numericality: { greater_than: 0.0, less_than: 3.402823466e+38, message: I18n.t('.out_of_range_error') }, presence: true

  scope :search_by_unit, ->(unit) { where(unit: unit) }
  scope :search_by_recipe_id, ->(recipe_id) { where(recipe_id: recipe_id) }

  # jitera-anchor-dont-touch: reset_password

  class << self
  end
end
