if @error_object.blank?
  json.rating do
    json.id @rating.id
    json.recipe_id @rating.recipe_id
    json.rater_id @rating.user_id
    json.rating @rating.rating
  end
else
  json.error @error_object
end
