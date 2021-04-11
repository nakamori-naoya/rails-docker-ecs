User.create!({
  email: 'aaaa@gmail.com',
  password: 'nigg1994',
  password_confirmation: 'nigg1994'
})


User.create!({
  email: 'test@gmail.com', 
  password: 'nigg1994',
  password_confirmation: 'nigg1994'
})

# Profile.create!({
#   nickName: "Nigg",
#   image_data: "https://www.google.com/url?sa=i&url=https%3A%2F%2Fgattolibero.hatenablog.com%2Fentry%2F%25E3%2583%259F%25E3%2583%258B%25E3%2583%259E%25E3%2583%25AA%25E3%2582%25B9%25E3%2583%2588%25E3%2580%2581%25E3%2582%25BF%25E3%2582%25A4%25E3%2583%25A9%25E3%2583%25BC%25E3%2583%25BB%25E3%2583%2580%25E3%2583%25BC%25E3%2583%2587%25E3%2583%25B3%25E3%2581%25AE%25E5%2590%258D%25E8%25A8%2580%25E9%259B%2586&psig=AOvVaw0SV7f2dtAamwYsUsgRSZZ5&ust=1615720452763000&source=images&cd=vfe&ved=0CAIQjRxqFwoTCOjJsu-Rre8CFQAAAAAdAAAAABAG",
#   user_id: 1
# })

# Profile.create!({
#   nickName: "Naoya",
#   image_data: "https://www.google.com/url?sa=i&url=https%3A%2F%2Fgattolibero.hatenablog.com%2Fentry%2F%25E3%2583%259F%25E3%2583%258B%25E3%2583%259E%25E3%2583%25AA%25E3%2582%25B9%25E3%2583%2588%25E3%2580%2581%25E3%2582%25BF%25E3%2582%25A4%25E3%2583%25A9%25E3%2583%25BC%25E3%2583%25BB%25E3%2583%2580%25E3%2583%25BC%25E3%2583%2587%25E3%2583%25B3%25E3%2581%25AE%25E5%2590%258D%25E8%25A8%2580%25E9%259B%2586&psig=AOvVaw0SV7f2dtAamwYsUsgRSZZ5&ust=1615720452763000&source=images&cd=vfe&ved=0CAIQjRxqFwoTCOjJsu-Rre8CFQAAAAAdAAAAABAG",
#   user_id: 2
# })


10.times do |n|
    Blog.create!(
      title: "User1の投稿",
      text: "hello world",
      user_id: 1,
      image_data: "aa"   
     )
  end

  10.times do |n|
    Blog.create!(
      title: "User2の投稿",
      text: "User2だよ",
      user_id: 2,
      image_data: "aa"
    )
  end  

10.times do |n|
    Comment.create!(
      title: "Tweet1に紐づくUser1による投稿だよ",
      text: "Hello#{n + 1}",
      blog_id: 1,
      user_id: 1
    )
end

10.times do |n|
  Comment.create!(
    title: "Tweet2に紐づくUser2による投稿だよ",
    text: "Hello#{n + 1}",
    blog_id: 2,
    user_id: 2
  )
end