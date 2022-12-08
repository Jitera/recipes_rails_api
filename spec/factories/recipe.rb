FactoryBot.define do
  factory :recipe do
    association :category

    association :user

    # jitera-anchor-dont-touch: columns
    difficulty { 'easy' }
    descriptions { Faker::Lorem.paragraph_by_chars(number: rand(0..1000)) }
    title { Faker::Lorem.paragraph_by_chars(number: rand(0..255)) }
  end
end
