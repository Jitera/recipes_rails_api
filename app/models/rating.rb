class Rating < ApplicationRecord
  include ConstantValidatable

  # jitera-anchor-dont-touch: relations

  belongs_to :recipe

  belongs_to :user

  # jitera-anchor-dont-touch: enum

  # jitera-anchor-dont-touch: file

  # jitera-anchor-dont-touch: validation

  validates :score, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }

  class << self
  end
end
