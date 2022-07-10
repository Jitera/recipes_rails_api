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

  validates :title, length: { maximum: 255, minimum: 0, message: I18n.t('errors.messages.out_of_range_error') }, presence: true

  validates :descriptions, length: { maximum: 65_535, minimum: 0, message: I18n.t('errors.messages.out_of_range_error') },
                           presence: true

  validates :time, length: { maximum: 255, minimum: 0, message: I18n.t('errors.messages.out_of_range_error') }, presence: true

  validates :difficulty, presence: true

  accepts_nested_attributes_for :ingredients

  def self.associations
    [:ingredients]
  end

  # jitera-anchor-dont-touch: reset_password

  class << self
    def search(conditions)
      query = ''
      values = []

      title = conditions.dig(:title)
      if title
        query << 'title LIKE ? '
        values << "%#{title}%"
      end

      time_start = conditions.dig(:time_start)
      time_end = conditions.dig(:time_end)
      if time_start
        query << 'and REGEXP_SUBSTR(time, "[0-9]+") >= ? '
        values << time_start
      end
      if time_end
        query << 'and REGEXP_SUBSTR(time, "[0-9]+") <= ? '
        values << time_end
      end

      difficulty = conditions.dig(:difficulty)
      if difficulty
        query << 'and difficulty = ? '
        values << difficulty
      end

      if query
        where(query, *values)
      else
        all
      end
    end
  end
end
