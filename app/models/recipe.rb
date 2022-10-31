class Recipe < ApplicationRecord
  include ConstantValidatable
  include Ratable

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

  validates :time, length: { maximum: 255, minimum: 0, message: I18n.t('.out_of_range_error') }, format: { with: /(\d+):[0-5]?[0-9]:00/ }, presence: true

  validates :difficulty, presence: true

  accepts_nested_attributes_for :ingredients

  def self.associations
    [:ingredients]
  end

  # jitera-anchor-dont-touch: reset_password

  scope :with_difficulty, ->(difficulty) { where(difficulty: difficulty) }
  scope :title_has, ->(title) { where('title like ?', "%#{title}%") }
  scope :time_within, ->(min_sec, max_sec) { where('time_to_sec(time) >= ? and time_to_sec(time) <= ?', min_sec, max_sec) }

  def time_string=(ts)
    m = ts.match(ConstantValidatable::TIME_DURATION_VALIDATION_FORMAT)
    return if m.nil?

    hr = m[1] || m[3]
    mn = m[2] || m[4]
    self.time = "#{hr}:#{mn}:00"
  end

  def time_string
    return '' if time.nil?

    time_arr = time.split ':'
    hr = time_arr[0].to_i
    mn = time_arr[1].to_i
    "#{hr} hours #{mn} mins"
  end

  class << self
  end
end
