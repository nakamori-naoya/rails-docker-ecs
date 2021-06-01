FactoryBot.define do
  factory :avg_eval do
    sociality {Faker::Number.within(range: 0.0..5.0)}
    creativity {Faker::Number.within(range: 0.0..5.0)}
    usability {Faker::Number.within(range: 0.0..5.0)}
    skill {Faker::Number.within(range: 0.0..5.0)}
    business_oriented {Faker::Number.within(range: 0.0..5.0)}
    comprehensive_evaluation {Faker::Number.within(range: 0.0..5.0)}
    association :portfolio
  end
end
