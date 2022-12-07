class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :recipe, counter_cache: true

  validates :user_id, uniqueness: { scope: :recipe_id, message: I18n.t('recipes.voted') }

  def voter_id
    user.id
  end

  def voter_email
    user.email
  end
end
