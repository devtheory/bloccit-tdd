require 'rails_helper'

RSpec.describe AdvertisementsController, type: :controller do
  let(:advertisement) { Advertisement.create!(title: "Become a Software Engineer!", copy: "it's the best job ever.", price: 10)}

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template('index')
    end

    it "instantiates @posts" do
      get :index
      expect(assigns(:advertisements)).to eq([advertisement])
    end
  end

  describe "GET #show" do
    it "returns http success" do
      get :show, {id: advertisement.id}
      expect(response).to have_http_status(:success)
    end

    it "renders the show template" do
      get :show, {id: advertisement.id}
      expect(response).to render_template('show')
    end

    it "instantiates @advertisement" do
      get :show, {id: advertisement.id}
      expect(assigns(:advertisement)).to eq(advertisement)
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end

    it "renders the new template" do
      get :new
      expect(response).to render_template('new')
    end

    it "instantiates @advertisement" do
      get :new
      expect(assigns(:advertisement)).not_to be_nil
    end
  end

  describe "POST create" do
    it "increases Post.count by 1" do
      expect{post :create, advertisement: {title: "Ad", copy: "the copy", price: 10}}.to change(Advertisement, :count).by(1)
    end

    it "instantiates @advertisement" do
      post :create, advertisement: {title: "Ad", copy: "the copy", price: 10}
      expect(assigns(:advertisement)).to eq(Advertisement.last)
    end

    it "redirects to @advertisement" do
      post :create, advertisement: {title: "Ad", copy: "the copy", price: 10}
      expect(response).to redirect_to(Advertisement.last)
    end
  end

end
