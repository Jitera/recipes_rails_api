class Recipe < ApplicationRecord
  include ConstantValidatable

  # jitera-anchor-dont-touch: relations

  has_many :ingredients, dependent: :destroy

  belongs_to :category

  belongs_to :user

  # jitera-anchor-dont-touch: enum
  enum difficulty: %w[easy normal challenging], _suffix: true

  # jitera-anchor-dont-touch: file

  # jitera-anchor-dont-touch: validation

  validates :title, length: { maximum: 255, minimum: 0, message: I18n.t('.out_of_range_error') }, presence: true

  validates :descriptions, length: { maximum: 65_535, minimum: 0, message: I18n.t('.out_of_range_error') },
                           presence: true

  # TODO: if time is the total number of minutes, there are recipes that require longer than 255 minutes to complete
  # if time is the total number of hours, there are recipes that require less than 1 hour to complete
  validates :time, length: { maximum: 255, minimum: 0, message: I18n.t('.out_of_range_error') }, presence: true

  # TODO: difficulty must be one of enum value
  validates :difficulty, presence: true

  accepts_nested_attributes_for :ingredients

  def self.associations
    [:ingredients]
  end

  # jitera-anchor-dont-touch: reset_password

  class << self
  end
end
