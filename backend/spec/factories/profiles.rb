FactoryBot.define do
  factory :profile do
    nickname {Faker::Name.name }
    self_introduction {Faker::Lorem.characters(number: 400)}
    programming_start_date {Faker::Date.between(from: '1900-01-01', to: '2021-12-31')}
    web_site_url {Faker::Lorem.sentence}
    association :user 
  end
end
