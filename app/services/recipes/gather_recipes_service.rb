module Recipes
  class GatherRecipesService < ApplicationService
    def initialize(recipes, params)
      @recipes = recipes
      @params = params
    end

    def call
      final_result = @params['title'] ? @recipes.search_by_title(@params['title']) : @recipes
      final_result = @params['difficulty'] ? final_result.search_by_difficulty(@params['difficulty']) : final_result
      @params['time'] ? search_by_time_range(final_result, @params['time']) : final_result
    end

    private

    def search_by_time_range(recipes, time)
      from, to = Recipes::ConvertTimeToMinutesService.call(time)
      raise(I18n.t('errors.from_time_must_be_before_to_time')) if from >= to

      recipe_ids = []
      recipes.find_each do |recipe|
        recipe_ids << recipe.id if recipe.from_time <= from && recipe.to_time >= to
      end

      Recipe.where(id: recipe_ids)
    end
  end
end
