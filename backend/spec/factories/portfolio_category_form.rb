FactoryBot.define do
  factory :portfolio_category_form do
    title {Faker::Lorem.characters(number: 30)}
    description {Faker::Lorem.characters(number: 400)}
    site_url {Faker::Lorem.sentence}
    github_url {Faker::Lorem.sentence}
    name {Faker::Lorem.characters(number: 20)}
  end
end