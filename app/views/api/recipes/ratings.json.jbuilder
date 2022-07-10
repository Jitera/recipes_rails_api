if @ratings.present?
  json.ratings @ratings do |rating|
    json.id rating.id
    json.created_at rating.created_at
    json.updated_at rating.updated_at
    json.points rating.points
    json.comments rating.comments

    json.recipe do
      json.id rating.recipe.id
      json.created_at rating.recipe.created_at
      json.updated_at rating.recipe.updated_at
      json.title rating.recipe.title
      json.descriptions rating.recipe.descriptions
      json.time rating.recipe.time
      json.difficulty rating.recipe.difficulty
      json.category_id rating.recipe.category_id
    end

    json.user do
      json.id rating.user.id
      json.email rating.user.email
      json.created_at rating.user.created_at
      json.updated_at rating.user.updated_at
    end
  end
else
  json.error_message @error_message
end
