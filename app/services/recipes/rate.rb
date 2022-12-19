# frozen_string_literal: true

module Recipes
  class Rate < BaseService
    attr_reader :data

    def initialize(recipe, params)
      super
      @recipe = recipe
      @params = params
    end

    def call
      if @params[:point].nil?
        add_error(I18n.t('errors.recipes.missing_point_in_params'))
        return self
      end

      recipe_rate = RecipeRate.new(
        user_id: @params[:user_id],
        recipe_id: @recipe.id,
        point: @params[:point]
      )
      unless recipe_rate.save
        add_error(recipe_rate.errors.full_messages)
        return self
      end

      @data = recipe_rate
      self
    end

  end
end
