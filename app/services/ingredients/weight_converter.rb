# frozen_string_literal: true

module Ingredients
  class WeightConverter < BaseService
    attr_reader :data

    def initialize(params)
      super
      @params = params
    end

    def call
      if @params[:from_unit].blank? || @params[:to_unit].blank? || @params[:from_amount].blank?
        add_error(I18n.t('errors.ingredients.missing_params_to_convert'))
        return self
      end

      if available_unit.exclude?(@params[:from_unit]) || available_unit.exclude?(@params[:to_unit])
        add_error(I18n.t('errors.ingredients.unsupported_unit'))
        return self
      end
      from_unit = @params[:from_unit]
      to_unit = @params[:to_unit]
      from_amount = @params[:from_amount]
      to_amount_gram = Ingredient::GRAM_CONVERTER[from_unit] * from_amount
      to_amount = (to_amount_gram * Ingredient::UNIT_CONVERTER_FROM_GRAM[to_unit]).round(2)
      @data = {
        from_unit: from_unit,
        to_unit: to_unit,
        from_amount: from_amount,
        to_amount: to_amount
      }
      self
    end

    private

    def available_unit
      @available_unit ||= %w[cup teaspoons gram kilogram]
    end
  end
end
