FactoryBot.define do
  factory :vote do
    association :user
    association :recipe, time: '1 min - 20 mins'
  end
end
