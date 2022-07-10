if @error_message.blank?
  json.unit_from @results[:unit_from]
  json.unit_to @results[:unit_to]
  json.amount_from @results[:amount_from]
  json.amount_to @results[:amount_to]
else
  json.error_message @error_message
end
