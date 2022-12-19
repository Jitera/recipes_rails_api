if @error_message.blank?
  json.user_id @data.user_id
  json.recipe_id @data.recipe_id
  json.point @data.point
  json.created_at @data.created_at
  json.updated_at @data.updated_at
else
  json.error_message @error_message
end
