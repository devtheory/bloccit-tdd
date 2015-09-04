require 'rails_helper'

RSpec.describe SponsoredPostsController, type: :controller do
  let(:topic) { Topic.create!(name: "a topic name", description: "a topic description")}
  let(:sponsored_post) { SponsoredPost.create!(title: "a sponsored post", body: "had a description", price: 100, topic: topic)}

  describe "GET show" do
    it "returns http success" do
      get :show, topic_id: topic.id, id: sponsored_post.id
      expect(response).to have_http_status(:success)
    end

    it "renders the show template" do
      get :show, topic_id: topic.id, id: sponsored_post.id
      expect(response).to render_template('show')
    end

    it "assigns @sponsored_post" do
      get :show, topic_id: topic.id, id: sponsored_post.id
      expect(assigns(:sponsored_post)).to eq(sponsored_post)
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new, topic_id: topic.id
      expect(response).to have_http_status(:success)
    end

    it "renders the new template" do
      get :new, topic_id: topic.id
      expect(response).to render_template('new')
    end

    it "initializes @sponsored_post" do
      get :new, topic_id: topic.id
      expect(assigns(:sponsored_post)).not_to be_nil
    end
  end

  describe "GET edit" do
    it "returns http success" do
      get :edit, topic_id: topic.id, id: sponsored_post.id
      expect(response).to have_http_status(:success)
    end

    it "renders the edit template" do
      get :edit, topic_id: topic.id, id: sponsored_post.id
      expect(response).to render_template('edit')
    end

    it "loads the @sponsored_post with the updated values" do
      get :edit, topic_id: topic.id, id: sponsored_post.id
      sponsored_post_instance = assigns(:sponsored_post)

      expect(sponsored_post_instance.id).to eq(sponsored_post.id)
      expect(sponsored_post_instance.title).to eq(sponsored_post.title)
      expect(sponsored_post_instance.body).to eq(sponsored_post.body)
      expect(sponsored_post_instance.price).to eq(sponsored_post.price)
    end
  end

end
