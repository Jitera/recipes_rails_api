class Converter

  # for units such as cup/teaspoon, the rate varies depends on the kind of the product
  # in case of ingredient, the converter can be easier if ingredient kind is known
  # in this case we will take a specific rate for a common kind as convert rate, for cup its dry goods, for teaspoon its salt
  BASE_RATES = {
    gram_gram: 1.0, # to cover the case convert to the same unit
    kilogram_gram: 1000.0,
    cup_gram: 128.0, # according to this https://www.allrecipes.com/article/cup-to-gram-conversions/ for all dry goods
    teaspoons_gram: 5.69 # according to this https://www.weekendbakery.com/cooking-conversions/ for salt ingredients
  }.with_indifferent_access

  FULL_RATES = {}.merge(BASE_RATES).with_indifferent_access

  BASE_RATES.each do |k, v|
    units = k.split('_')
    from = units[0]
    to = units[1]
    FULL_RATES["#{from}_#{to}"] = v
    FULL_RATES["#{to}_#{from}"] = 1 / v
  end

  class << self
    # return converted value if convertible, otherwise return -1
    def convert(from, to, amount)
      # convert using normal rate
      convert_rate = FULL_RATES["#{from}_#{to}"]
      return amount * convert_rate if convert_rate.present?

      # convert using reverse rate
      reverse_rate = FULL_RATES["#{to}_#{from}"]
      return amount * reverse_rate if reverse_rate.present?

      # convert using the third bridge rate from -> gram -> to
      from_to_gram_rate = FULL_RATES["#{from}_gram"]
      gram_to_to_rate = FULL_RATES["gram_#{to}"]

      return -1 if from_to_gram_rate.blank? || gram_to_to_rate.blank?

      amount * from_to_gram_rate * gram_to_to_rate
    end
  end
end
