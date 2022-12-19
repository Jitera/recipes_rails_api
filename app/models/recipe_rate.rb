# frozen_string_literal: true

class RecipeRate < ApplicationRecord
  include ConstantValidatable
  belongs_to :user
  belongs_to :recipe
end
