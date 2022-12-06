module Recipes
  class ConvertTimeToMinutesService < ApplicationService
    def initialize(time)
      @time = time
    end

    def call
      times = @time.split('-').map(&:strip)
      from = calculate(times.first)
      to = calculate(times.last)
      [from, to]
    end

    private

    def calculate(time)
      return time.scan(/\d+/).map(&:to_i).first unless time.include?('hour') || time.include?('hours')

      unit_numbers = time.scan(/\d+/).map(&:to_i)
      return unit_numbers.first * 60 if unit_numbers.size == 1

      (unit_numbers.first * 60) + unit_numbers.last
    end
  end
end
