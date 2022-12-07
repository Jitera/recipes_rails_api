module Votes
  class FullSerializer < BaseSerializer
    attributes :id, :created_at, :updated_at, :user_id, :recipe_id
  end
end
