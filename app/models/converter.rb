class Converter
  include ActiveModel::API

  UNIT_RATIOS = { "cup" => 1, "teaspoons" => 48, "gram" => 130, "kilogram" => 0.13 }
  UNITS = %w[cup teaspoons gram kilogram]

  attr_accessor :from_unit, :to_unit, :from_amount

  validates :from_unit, :to_unit, presence: true, inclusion: UNITS
  validates :from_amount, presence: true, numericality: true

  def to_amount
    UNIT_RATIOS[to_unit] * from_amount.to_f / UNIT_RATIOS[from_unit]
  end
end
