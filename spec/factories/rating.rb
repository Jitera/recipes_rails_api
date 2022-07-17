FactoryBot.define do
  factory :rating do
    recipe

    user

    # jitera-anchor-dont-touch: columns
    score { rand(0..5) }
  end
end
