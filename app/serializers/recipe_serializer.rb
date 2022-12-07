class RecipeSerializer < BaseSerializer
  attributes :id, :created_at, :updated_at, :title, :descriptions, :time, :difficulty, :category_id, :votes_count

  attribute :owner_id

  has_many :ingredients
  has_many :votes, serializer: Votes::DetailVoterInfoSerializer

  def owner_id
    object.user_id
  end
end
