module Recipes
  class GatherRecipesService < ApplicationService
    def initialize(recipes, params)
      @recipes = recipes
      @params = params
    end

    def call
      term = @params['term']
      return @recipes unless term

      from, to = Recipes::ConvertTimeToMinutesService.call(term[:time]) if term[:time]

      recipe_ids = recipe_ids_by_time_range(@recipes, from, to) if from && to

      final_result = term[:title].present? ? @recipes.search_by_title(term[:title]) : @recipes
      final_result = term[:difficulty].present? ? final_result.search_by_difficulty(term[:difficulty]) : final_result
      recipe_ids.nil? ? final_result : final_result.where(id: recipe_ids)
    end

    private

    def recipe_ids_by_time_range(recipes, from, to)
      raise(I18n.t('errors.from_time_must_be_before_to_time')) if from && to && from >= to

      recipe_ids = []
      recipes.find_each do |recipe|
        recipe_ids << recipe.id if from && to && recipe.from_time <= from && recipe.to_time >= to
      end
      recipe_ids
    end
  end
end
