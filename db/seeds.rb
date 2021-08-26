10.times do |n|
  User.create(
    last_name: Faker::Name.unique.last_name,
    first_name: Faker::Name.unique.first_name,
    email: Faker::Internet.unique.email,
    password: "password",
    password_confirmation: "password"
  )
end

20.times do |index|
    Board.create(
      user: User.offset(rand(User.count)).first,
      title: "タイトル#{index}",
      body: "本文#{index}"
    )
end


