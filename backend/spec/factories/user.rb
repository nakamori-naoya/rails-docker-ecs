FactoryBot.define do
  factory :user do
    email  {Faker::Internet.free_email}  
    password  {Faker::Internet.password(min_length: 6, max_length: 20, mix_case: false)}  #半角英数字6文字以上
  end
end