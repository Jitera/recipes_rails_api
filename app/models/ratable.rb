module Ratable
  extend ActiveSupport::Concern

  included do
    has_many :ratings
  end

  def create_or_update_user_rating(user:, rating:)
    rating_record = ratings.find_or_initialize_by(user: user)
    rating_record.rating = rating
    rating_record.save

    rating_record
  end
end
