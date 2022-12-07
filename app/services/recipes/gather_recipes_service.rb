module Recipes
  class GatherRecipesService < ApplicationService
    def initialize(recipes, params)
      @recipes = recipes
      @params = params
    end

    def call
      return @recipes unless @params['search']

      search = @params['search']
      from, to = Recipes::ConvertTimeToMinutesService.call(search)

      recipe_ids = recipe_ids_by_time_range(@recipes, from, to)
      @recipes.search_by_title(search).or(@recipes.search_by_difficulty(search)).or(@recipes.where(id: recipe_ids))
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
