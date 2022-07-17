require 'rails_helper'

RSpec.describe Rating, type: :model do
  let(:rating) do
    build(:rating)
  end

  describe 'Assocations' do
    it { is_expected.to belong_to(:recipe) }

    it { is_expected.to belong_to(:user) }
  end

  describe 'Valid subject' do
    it 'is valid rating' do
      expect(rating).to be_valid
    end
  end

  describe 'Invalid score validations' do
    it 'min score is 0' do
      rating.score = -1
      expect(rating).not_to be_valid
    end

    it 'max score is 5' do
      rating.score = 50
      expect(rating).not_to be_valid
    end

    it 'score is integer' do
      rating.score = 0.2
      expect(rating).not_to be_valid
    end

    it 'score is required' do
      rating.score = nil
      expect(rating).not_to be_valid
    end
  end
end
