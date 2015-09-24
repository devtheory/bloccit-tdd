include RandomData

# Create Users

5.times do
  user = User.create!(
    name: RandomData.random_name, 
    email: RandomData.random_email, 
    password: RandomData.random_sentence
  )
end

users = User.all

users.first.update_attributes!(email: "admin@example.com", password: "password", role: 'admin', name: "Admin user")
users.last.update_attributes!(email: "member@example.com", password: "password", role: 'member', name: "Member user")

# Create Topics

15.times do
  Topic.create!(
      name: RandomData.random_sentence,
      description: RandomData.random_paragraph
    )
end

topics = Topic.all

# Create Posts
50.times do
  Post.create!(
      title: RandomData.random_sentence,
      body: RandomData.random_paragraph,
      topic: topics.sample,
      user: users.sample
    )
end

posts = Post.all

# Create Comments

100.times do
  Comment.create!(
      body: RandomData.random_paragraph,
      post: posts.sample,
      user: users.sample
    )
end

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Topic.count} Topics created"
puts "#{Post.count} Posts created"
puts "#{Comment.count} Comments created"