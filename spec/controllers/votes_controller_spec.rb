require 'rails_helper'
include RandomData
include SessionsHelper

RSpec.describe VotesController, type: :controller do
  let(:my_user) { create(:user) }
  let(:other_user) { create(:user) }
  let (:my_topic) { create(:topic)}
  let(:my_post) { create(:post, user: my_user, topic: my_topic) }
  let(:user_post) {create(:post, topic: my_topic, user: other_user)}
  let(:my_vote) { Vote.create!(value: 1) }

  context "guest" do
    describe "POST up_vote" do
      it "redirects the user to the sign in view" do
        post :up_vote, post_id: my_post.id
        expect(response).to redirect_to(new_session_path)
      end
      it "redirects the user to the sign in view" do
        post :down_vote, post_id: my_post.id
        expect(response).to redirect_to(new_session_path)
      end
    end
  end

  context "signed in user" do
    before do
      create_session(my_user)
      request.env['HTTP_REFERER'] = [my_topic, my_post]
    end

    describe "POST up_vote" do
      it "increases the vote count on the user's first vote on a post" do
        votes = my_post.votes.count
        post :up_vote, post_id: my_post.id
        expect(my_post.votes.count).to eq(votes)
      end

      it "does not increase after the initial vote was given" do
        post :up_vote, post_id: my_post.id
        votes = my_post.votes.count
        post :up_vote, post_id: my_post.id
        expect(my_post.votes.count).to eq(votes)
      end

      it "increases the sum of post points by one" do
        points = my_post.points
        post :up_vote, post_id: my_post.id
        expect(my_post.points).to eq(points)
      end

      it "uses :back to redirect to posts show page" do
        request.env["HTTP_REFERER"] = topic_post_path(my_topic, my_post)
        post :up_vote, post_id: my_post.id
        expect(response).to redirect_to([my_topic, my_post])
      end
    end

    describe "POST down_vote" do
      it "increases the vote count on the user's first vote on a post" do
        votes = my_post.votes.count
        post :down_vote, post_id: my_post.id
        expect(my_post.votes.count).to eq(votes)
      end

      it "does not increase after the initial vote was given" do
        post :down_vote, post_id: my_post.id
        votes = my_post.votes.count
        post :down_vote, post_id: my_post.id
        expect(my_post.votes.count).to eq(votes)
      end

      it "decreases the sum of post points by one" do
        points = my_post.points
        post :down_vote, post_id: my_post.id
        expect(my_post.points).to eq(points - 1)
      end

      it "uses :back to redirect to posts show page" do
        request.env["HTTP_REFERER"] = topic_post_path(my_topic, my_post)
        post :down_vote, post_id: my_post.id
        expect(response).to redirect_to([my_topic, my_post])
      end
    end
  end
end
