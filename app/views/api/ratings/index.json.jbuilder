json.ratings @ratings do |rating|
  json.id rating.id
  json.created_at rating.created_at
  json.updated_at rating.updated_at
  json.score rating.score

  json.user do
    json.id rating.user.id
    json.email rating.user.email
  end
end

json.total_pages @ratings.total_pages
json.current_page @ratings.current_page
json.total_count @ratings.total_count