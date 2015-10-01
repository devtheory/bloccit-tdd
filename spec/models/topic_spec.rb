require 'rails_helper'
include RandomData

RSpec.describe Topic, type: :model do
  let(:topic) { create(:topic)}
  let(:private_topic) { create(:topic, public: false)}

  it { should have_many(:posts)}
  it {should have_many(:labelings)}
  it {should have_many(:labels).through(:labelings)}

  it {should validate_presence_of(:name)}
  it {should validate_presence_of(:description)}

  it {should validate_length_of(:name).is_at_least(5)} 
  it {should validate_length_of(:description).is_at_least(15)}

  describe "attributes" do
    it "should respond to name" do
      expect(topic).to respond_to(:name)
    end

    it "should respond to description" do
      expect(topic).to respond_to(:description)
    end

    it "should respond to public" do
      expect(topic).to respond_to(:public)
    end

    it "should be public by default" do
      expect(topic.public).to be(true)
    end
  end

  describe "scopes" do
    describe "visible_to(user)" do
      it "returns all topics if user is signed in" do
        user = User.new
        expect(Topic.visible_to(user)).to eq([topic, private_topic])
      end

      it "returns only public topics if there is no user" do
        expect(Topic.visible_to(nil)).to eq([topic])
      end
    end

    describe "publicly_viewable" do
      it "returns a collection of only public topics" do
        expect(Topic.publicly_viewable).to eq([topic])
      end
    end

    describe "privately_viewable" do
      it "returns a collection of only private topics" do
        expect(Topic.privately_viewable).to eq([private_topic])
      end
    end
  end
end
