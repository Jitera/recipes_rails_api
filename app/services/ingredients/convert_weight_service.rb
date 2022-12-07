module Ingredients
  class ConvertWeightService < ApplicationService
    def initialize(amount, unit)
      @amount = amount
      @unit = unit
    end

    def call
      invalid_units = Ingredient.units.except(:gram, :kilogram).keys

      raise(I18n.t('errors.invalid_unit_to_convert')) if invalid_units.include?(@unit)

      return convert_to_gram if @unit == 'kilogram'

      convert_to_kilogram if @unit == 'gram'
    end

    private

    def convert_to_gram
      amount = (@amount * 1_000).to_f
      "#{amount} gram"
    end

    def convert_to_kilogram
      amount = @amount.to_f / 1_000
      "#{amount} kilogram"
    end
  end
end
