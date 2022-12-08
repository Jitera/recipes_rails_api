require 'rails_helper'

RSpec.describe Vote, type: :model do
  describe 'validations' do
    it 'validates uniqueness of user_id scoped to recipe_id' do
      vote1 = create(:vote)
      vote2 = build(:vote, user_id: vote1.user_id, recipe_id: vote1.recipe_id)
      expect(vote2).not_to be_valid
    end
  end

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:recipe) }
  end
end
