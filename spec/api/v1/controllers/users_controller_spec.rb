require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  let(:my_user) { create(:user)}

  context "unauthenticated users" do
    it "returns http unauthenticated for GET index" do
      get :index
      expect(response).to have_http_status(401)
    end

    it "returns http unauthenticated for GET show" do
      get :show, id: my_user.id
      expect(response).to have_http_status(401)
    end
  end

  context "authentiacted and unauthorized users" do
    before do
      controller.request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(my_user.auth_token)
    end

    it "returns http forbidden for GET index" do
      get :index
      expect(response).to have_http_status(403)
    end

    it "returns http forbidden for GET show" do
      get :show, id: my_user.id
      expect(response).to have_http_status(403)
    end
  end

  context "authenticated and authorized users" do
    before do
      my_user.admin!
      controller.request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(my_user.auth_token)
    end

    describe "GET index" do
      before do 
        get :index
      end

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end

      it "returns json content type" do
        expect(response.content_type).to eq('application/json')
      end

      it "returns my_user serialized" do
        expect([my_user].to_json).to eq(response.body)
      end
    end

    describe "GET show" do
      before do
        get :show, id: my_user.id
      end

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end

      it "returns json content type" do
        expect(response.content_type).to eq('application/json')
      end

      it "returns my_user serialized" do
        expect(my_user.to_json).to eq(response.body)
      end
    end
  end
end