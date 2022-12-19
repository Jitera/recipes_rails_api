if @success
  json.success @success

  json.user do
    json.id @user.id

    json.email @user.email

    json.created_at @user.created_at

    json.updated_at @user.updated_at
  end

else
  json.success @success
  json.error_message @error_message

end
