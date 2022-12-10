module Categories
  class GatherCategoriesService < ApplicationService
    def initialize(categories, params)
      @categories = categories
      @params = params
    end

    def call
      term = @params['term']
      return @categories unless term


      term[:description].present? ? @categories.search_by_description(term[:description]) : @categories
    end
  end
end
