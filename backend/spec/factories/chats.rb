FactoryBot.define do
  factory :chat do
    text {Faker::Lorem.characters(number: 400)}
  end
end
