require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:new_user_attributes) do
    { name: "Blochead", email: "blochead@bloc.io", password: "blochead", password_confirmation: 'blochead'}
  end

  describe "GET new" do

    it 'returns http success' do
      get :new
      expect(response).to have_http_status(:success)
    end

    it 'renders the new template' do
      get :new
      expect(response).to render_template('new')
    end

    it 'instantiates a new user' do
      get :new
      expect(assigns(:user)).to_not be_nil
    end
  end

  describe "POST create" do
    it 'returns http success' do
      post :create, user: new_user_attributes
      expect(response).to have_http_status(:redirect)
    end

    it 'creates a new user' do
      expect {
        post :create, user: new_user_attributes
      }.to change(User, :count).by(1)
    end

    it 'sets the name correctly' do
      post :create, user: new_user_attributes
      expect(assigns(:user).name).to eq(new_user_attributes[:name])
    end 

    it 'sets the email correctly' do
      post :create, user: new_user_attributes
      expect(assigns(:user).email).to eq(new_user_attributes[:email])
    end

    it 'sets the password correctly' do
      post :create, user: new_user_attributes
      expect(assigns(:user).password).to eq(new_user_attributes[:password])
    end 

    it 'sets the password_confirmation correctly' do
      post :create, user: new_user_attributes
      expect(assigns(:user).password_confirmation).to eq(new_user_attributes[:password_confirmation])
    end 

    it 'logs the user in after sign up' do
      post :create, user: new_user_attributes
      expect(session[:user_id]).to eq(assigns(:user).id)
    end
  end
end
