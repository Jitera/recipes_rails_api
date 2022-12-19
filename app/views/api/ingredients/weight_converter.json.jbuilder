if @error_message.blank?
  json.from_unit @data[:from_unit]
  json.from_amount @data[:from_amount]
  json.to_unit @data[:to_unit]
  json.to_amount @data[:to_amount]
else
  json.error_message @error_message
end
