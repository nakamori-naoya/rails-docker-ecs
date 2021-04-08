User.destroy_all

User.create!({
    email: 'test@user.com',
    nickName: "nigg",
    password_digest: 'test123456',
    password_confirmation: 'test123456'
  })