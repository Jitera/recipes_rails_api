if @error_message.blank?
  json.recipe do
    json.id @recipe.id
    json.ratings @recipe.ratings do |rating|
      json.id rating.id
      json.recipe_id rating.recipe_id
      json.rater_id rating.user_id
      json.rating rating.rating
    end
  end
else
  json.error_message @error_message
end
