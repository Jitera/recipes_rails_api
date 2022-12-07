module ResponseHandlerConcern
  extend ActiveSupport::Concern

  SUCCESS_STATUS = :success
  ERROR_STATUS   = :fail

  def error_msg_active_record(resource, error)
    {
      status: ERROR_STATUS,
      full_messages: resource&.errors&.full_messages,
      errors: resource&.errors,
      error_message: error.message,
      backtrace: error.backtrace
    }
  end

  def json_with_success(message: :success, data: nil, options: {})
    instance_options = options[:serialize] || {}
    instance_options[:include] = '**'
    {
      status: SUCCESS_STATUS,
      message: options[:message] || message || 'Success',
      data: data ? serialize(data, instance_options).as_json : nil
    }
  end

  def json_with_error(message: :fail, errors: nil)
    {
      status: ERROR_STATUS,
      message: message,
      errors: errors
    }
  end

  def json_with_pagination(message: :success, data: nil, custom_serializer: nil, options: {})
    {
      status: SUCCESS_STATUS,
      message: message,
      data: pagination_json(data, custom_serializer: custom_serializer, options: options) || nil
    }
  end

  private

  def serialize(data, option = {})
    ActiveModelSerializers::SerializableResource.new(
      data,
      option
    ).serializable_hash.as_json
  end

  def pagination_json(data, custom_serializer: nil, options: {})
    pagination =
      {
        limit_value: data.respond_to?(:limit_value) && data.limit_value ? data.limit_value : 0,
        current_page: data.respond_to?(:current_page) ? data.current_page : 1,
        next_page: data.respond_to?(:next_page) ? data.next_page : nil,
        prev_page: data.respond_to?(:prev_page) ? data.prev_page : nil,
        total_pages: data.respond_to?(:total_pages) ? data.total_pages : 1
      }

    options = custom_serializer ? { each_serializer: custom_serializer }.merge(options) : options
    options[:include] = '**'

    {
      pagination: pagination,
      items: serialize(data, options)
    }
  end
end
