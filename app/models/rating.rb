class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :recipe

  validates :rating, numericality: { only_integer: true, in: 1..5 }, presence: true

  def self.rate(user, recipe, rating)
    rating_record = Rating.find_or_initialize_by(user: user, recipe: recipe)
    rating_record.rating = rating
    rating_record.save
  end
end
