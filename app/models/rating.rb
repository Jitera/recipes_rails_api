class Rating < ApplicationRecord
  belongs_to :recipe
  belongs_to :user

  validates :user_id, presence: { message: "User ID is required" }
  validates :recipe_id, presence: { message: "Recipe ID is required" }
end