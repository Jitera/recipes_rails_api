module ConstantValidatable
  HIRAGANA_VALIDATION_FORMAT = %r{\A[ぁ-んー－]+\z} # rubocop:disable Style/RegexpLiteral
  KATAKANA_VALIDATION_FORMAT = %r{\A[ァ-ヶー－]+\z} # rubocop:disable Style/RegexpLiteral
  URL_VALIDATION_FORMAT = %r{\A(http|https)://[a-z0-9]+([\-.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(/.*)?\z}
  PHONE_NUMBER_VALIDATION_FORMAT = %r{\A[+]?[(]?[0-9]{3}[)]?[-\s.]?[0-9]{3}[-\s.]?[0-9]{4,6}\z} # rubocop:disable Style/RegexpLiteral
  TIME_DURATION_VALIDATION_FORMAT = %r{\A(\d+)(?:\s*hours?)\s*(\d+)(?:\s*mins?)|(\d+)(?:\s*hours?)|(\d+)(?:\s*mins?)\z} # rubocop:disable Style/RegexpLiteral
  TIME_DURATION_RANGE_VALIDATION_FORMAT =
    /\A
      ((\d+)(?:\s*hours?)\s*(\d+)(?:\s*mins?)|(\d+)(?:\s*hours?)|(\d+)(?:\s*mins?)) # min time duration
      \s*-\s*
      ((\d+)(?:\s*hours?)\s*(\d+)(?:\s*mins?)|(\d+)(?:\s*hours?)|(\d+)(?:\s*mins?)) # max time duration
    \z/x
end
