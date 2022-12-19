# frozen_string_literal: true

class BaseService
  def initialize(*_args)
    @errors = []
  end

  class << self
    def call(*args)
      service_obj = new(*args)

      service_obj.call
    end
  end

  attr_reader :errors

  def success?
    errors.blank?
  end

  def error?
    !success?
  end

  def first_error
    errors.first
  end

  def error_messages
    return [] if errors.blank?

    errors&.each_with_object([]) do |error, error_messages|
      case error
      when Exception
        error_messages << error.message
      when ActiveModel::Errors
        error_messages.concat(error.full_messages)
      else
        error_messages << error.to_s
      end
    end
  end

  def add_error(error)
    puts error
    return if error.nil?

    @errors ||= []

    case error
    when ::StandardError
      @errors << error
    when Array
      error.each { |e| add_error(e) }
    else
      errors << error.to_s
    end
  end
end
