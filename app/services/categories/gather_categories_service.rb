module Categories
  class GatherCategoriesService < ApplicationService
    def initialize(categories, params)
      @categories = categories
      @params = params
    end

    def call
      search = @params['search']
      return @categories unless search

      @categories.search_by_description(search)
    end
  end
end
