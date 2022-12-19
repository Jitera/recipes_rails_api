# frozen_string_literal: true

module Recipes
  class List < BaseService
    attr_reader :data

    def initialize(params)
      super()
      @params = params
    end

    # rubocop:disable Metrics/AbcSize
    def call
      recipes = Recipe.includes(:ingredients, :recipe_rates).all
      recipes = recipes.where(category_id: @params[:category_id]) if @params[:category_id]
      recipes = recipes.where(user_id: @params[:user_id]) if @params[:user_id]
      recipes = recipes.where(difficulty: @params[:difficulty]) if @params[:difficulty]
      recipes = recipes.where('LOWER(descriptions) LIKE ?', "%#{@params[:descriptions].to_s.downcase}%") if @params[:descriptions]
      recipes = recipes.where('LOWER(title) LIKE ?', "%#{@params[:title].to_s.downcase}%") if @params[:title]
      if time
        recipes = recipes.where('CAST(time AS UNSIGNED) <= ?', time.last)
        recipes = recipes.where('CAST(time AS UNSIGNED) >= ?', time.first)
      end

      @data = recipes
      self
    end

    # rubocop:enable Metrics/AbcSize

    private

    def time
      return unless @params[:time]

      times = @params[:time].delete(' ').split('-')
      from = calculate_time(times.first)
      to = calculate_time(times.last)
      [from, to]
    end

    def calculate_time(time)
      return time.scan(/\d+/).map(&:to_i).first unless time.include?('hour') || time.include?('hours')

      unit_numbers = time.scan(/\d+/).map(&:to_i)
      return unit_numbers.first * 60 if unit_numbers.size == 1

      (unit_numbers.first * 60) + unit_numbers.last
    end
  end
end
