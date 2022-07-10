if @error_object.blank?
  json.rating do
    json.id @rating.id
    json.created_at @rating.created_at
    json.updated_at @rating.updated_at
    json.points @rating.points
    json.comments @rating.comments
    json.user_id @rating.user_id
    json.recipe_id @rating.recipe_id
  end
else
  json.error_object @error_object
end
