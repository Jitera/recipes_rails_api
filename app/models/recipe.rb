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

  validates :time, length: { maximum: 255, minimum: 0, message: I18n.t('.out_of_range_error') }, presence: true

  validates :difficulty, presence: true

  accepts_nested_attributes_for :ingredients

  scope :search_by_title, ->(title) { where('title LIKE ?', "%#{title}%") }
  scope :search_by_difficulty, ->(difficulty) { where(difficulty: difficulty) }

  def self.associations
    [:ingredients]
  end

  def from_time
    ::Recipes::ConvertTimeToMinutesService.call(time).first
  end

  def to_time
    ::Recipes::ConvertTimeToMinutesService.call(time).last
  end

  # jitera-anchor-dont-touch: reset_password

  class << self
  end
end
