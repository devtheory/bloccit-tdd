include RandomData

# Create Posts
50.times do
  Post.create!(
      title: RandomData.random_sentence,
      body: RandomData.random_paragraph
    )
end

posts = Post.all

# Create Comments

100.times do
  Comment.create!(
      body: RandomData.random_paragraph,
      post: posts.sample
    )
end

# Unique post
Post.find_or_create_by!(title: "My custom Post", body: "My custom body")

puts "Seed finished"
puts "#{Post.count} Posts created"
puts "#{Comment.count} Comments created"