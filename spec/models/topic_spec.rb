require 'rails_helper'
include RandomData

RSpec.describe Topic, type: :model do
  let(:topic) { create(:topic)}

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
    before do
      @public_topic = create(:topic)
      @private_topic = create(:topic, public: false)
    end

    describe "visible_to(user)" do
      it "returns all topics if user is signed in" do
        user = User.new
        expect(Topic.visible_to(user)).to eq([@public_topic, @private_topic])
      end

      it "returns only public topics if there is no user" do
        expect(Topic.visible_to(nil)).to eq([@public_topic])
      end
    end
  end
end
