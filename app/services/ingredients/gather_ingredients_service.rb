module Ingredients
  class GatherIngredientsService < ApplicationService
    def initialize(ingredients, params)
      @ingredients = ingredients
      @params = params
    end

    def call
      term = @params['term']
      return @ingredients unless term

      final_result = term[:unit].present? ? @ingredients.search_by_unit(term[:unit]) : @ingredients
      term[:recipe_id].present? ? final_result.search_by_recipe_id(term[:recipe_id]) : final_result
    end
  end
end
