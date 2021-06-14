FactoryBot.define do
  factory :portfolio do
    title {Faker::Lorem.characters(number: 30)}
    self_introduction {Faker::Lorem.characters(number: 400)}
    site_url {Faker::Lorem.sentence}
    github_url {Faker::Lorem.sentence}
    association :user
  end
end
