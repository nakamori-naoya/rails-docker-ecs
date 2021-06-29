20.times do |n|
  User.create!(
    email: Faker::Internet.unique.free_email,
    password: "test1234"
  )
end

# 10.times do |n|
#     Profile.create!(
#     nickname: Faker::Name.unique.name,
#     self_introduction: Faker::Lorem.characters(number: 400),
#     programming_start_date: Faker::Date.between(from: '1900-01-01', to: '2021-12-31'),
#     web_site_url: Faker::Lorem.sentence,
#     user_id: n + 1,
#     )
# end

# 10.times do |n|
#   Profile.create!(
#   nickname: Faker::Name.unique.name,
#   description: Faker::Lorem.characters(number: 400),
#   programming_start_date: Faker::Date.between(from: '1900-01-01', to: '2021-12-31'),
#   web_site_url: Faker::Lorem.sentence,
#   image:  open("./db/fixtures/DHH.jpeg"),
#   user_id: n + 11
#   )
# end



# 60.times do |n|
#   Portfolio.create!(
#     title: "User2の投稿",
#     description: "ajfafa",
#     site_url: "https://github.com/nakamori-naoya",
#     github_url: "https://github.com/nakamori-naoya",
#     user_id: 2,   
#     )
# end


10.times do |n|
  name = Faker::ProgrammingLanguage.name
  Category.create!({
    name: name,
  })
end

# 200.times do |n|
#   name = Faker::Lorem.paragraph(sentence_count: 2, supplemental: true, random_sentences_to_add: 1)
#   Category.create!({
#     name: name,
#   })
# end



# # Profile.create!({
# #   nickName: "Naoya",
# #   image_data: "https://www.google.com/url?sa=i&url=https%3A%2F%2Fgattolibero.hatenablog.com%2Fentry%2F%25E3%2583%259F%25E3%2583%258B%25E3%2583%259E%25E3%2583%25AA%25E3%2582%25B9%25E3%2583%2588%25E3%2580%2581%25E3%2582%25BF%25E3%2582%25A4%25E3%2583%25A9%25E3%2583%25BC%25E3%2583%25BB%25E3%2583%2580%25E3%2583%25BC%25E3%2583%2587%25E3%2583%25B3%25E3%2581%25AE%25E5%2590%258D%25E8%25A8%2580%25E9%259B%2586&psig=AOvVaw0SV7f2dtAamwYsUsgRSZZ5&ust=1615720452763000&source=images&cd=vfe&ved=0CAIQjRxqFwoTCOjJsu-Rre8CFQAAAAAdAAAAABAG",
# #   user_id: 2
# # })


# 10.times do |n|
#     Eval.create!(
#       sociality: 2.5,
#       usability: 2.0,
#       business_oriented: 1.5,
#       creativity: 2.0,
#       skill: 2.0,
#       comprehensive_evaluation: 2.0, 
#       user_id: 1,
#       portfolio_id: 2
#       )
#   end

#   10.times do |n|
#     Eval.create!(
#       sociality: 2.5,
#       usability: 2.0,
#       business_oriented: 1.5,
#       creativity: 2.0,
#       skill: 2.0,
#       comprehensive_evaluation: 2.0, 
#       user_id: 2,
#       portfolio_id: n + 11  
#      )
#   end



  # 1.times do |n|
  #   AvgEval.create!(
  #     sociality: 2.5,
  #     usability: 2.0,
  #     business_oriented: 1.5,
  #     creativity: 2.0,
  #     skill: 2.0,
  #     comprehensive_evaluation: 2.0, 
  #     portfolio_id: 2
  #     )
  # end

#   10.times do |n|
#     AvgEval.create!(
#       sociality: 2.5,
#       usability: 2.0,
#       business_oriented: 1.5,
#       creativity: 2.0,
#       skill: 2.0,
#       comprehensive_evaluation: 2.0, 
#       user_id: 1,
#       portfolio_id: n + 11
#      )
#   end

  # 10.times do |n|
  #   Chat.create!(
  #     text: "hello#{n + 1}",
  #     user_id: 2,
  #     portfolio_id: 2  
  #     )
  # end

  # 10.times do |n|
  #   Chat.create!(
  #     text: "goodbye#{n + 1}",
  #     user_id: 1,
  #     portfolio_id: 2  
  #     )
  # end

# #   10.times do |n|
# #     Blog.create!(
# #       title: "User2の投稿",
# #       text: "User2だよ",
# #       user_id: 2,
# #       image_data: "aa"
# #     )
# #   end  

# # 10.times do |n|
# #     Comment.create!(
# #       title: "Tweet1に紐づくUser1による投稿だよ",
# #       text: "Hello#{n + 1}",
# #       blog_id: 1,
# #       user_id: 1
# #     )
# # end

# # 10.times do |n|
# #   Comment.create!(
# #     title: "Tweet2に紐づくUser2による投稿だよ",
# #     text: "Hello#{n + 1}",
# #     blog_id: 2,
# #     user_id: 2
# #   )
# # end