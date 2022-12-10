FactoryBot.define do
  factory :ingredient do
    recipe

    # jitera-anchor-dont-touch: columns
    amount { 1.0 }
    unit { 'cup' }

    trait :with_recipe_has_time do
      association :recipe, time: '1 min - 1 hour'
      amount { 1.0 }
      unit { 'gram' }
    end
  end
end
