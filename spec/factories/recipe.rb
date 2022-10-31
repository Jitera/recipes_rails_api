FactoryBot.define do
  factory :recipe do
    category

    user

    # jitera-anchor-dont-touch: columns
    difficulty { 'easy' }
    time { '1:30:00' }
    descriptions { Faker::Lorem.paragraph_by_chars(number: rand(0..1000)) }
    title { Faker::Lorem.paragraph_by_chars(number: rand(0..255)) }
  end
end
