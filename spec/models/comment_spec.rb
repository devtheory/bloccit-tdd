require 'rails_helper'
include RandomData

RSpec.describe Comment, type: :model do
  let(:topic) { Topic.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph)}
  let(:user) {User.create!(name: "Bloccit User", email: "user@bloccit.com", password: "password")}
  let(:post) { topic.posts.create!(title: "New Post Title", body: "New Post Body that meets length", user: user)}
  let(:comment) { Comment.create!(body: "New Comment Body", post: post)}

  describe "attributes" do
    it "should respond to body" do
      expect(comment).to respond_to(:body)
    end
  end
end
