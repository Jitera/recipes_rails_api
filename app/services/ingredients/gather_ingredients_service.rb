module Ingredients
  class GatherIngredientsService < ApplicationService
    def initialize(ingredients, params)
      @ingredients = ingredients
      @params = params
    end

    def call
      search = @params['search']
      return @ingredients unless search

      @ingredients.search_by_unit(search).or(@ingredients.search_by_recipe_id(search))
    end
  end
end
