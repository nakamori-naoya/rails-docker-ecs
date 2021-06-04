FactoryBot.define do
  factory :chat do
    text {Faker::Lorem.characters(number: 50)}
  end
end
