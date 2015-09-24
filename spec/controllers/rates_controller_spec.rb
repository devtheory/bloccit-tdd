require 'rails_helper'

RSpec.describe RatesController, type: :controller do
  let(:rate) { Rate.create!(severity: "PG")}

  describe "GET #show" do
    it "returns http success" do
      get :show, id: rate.id
      expect(response).to have_http_status(:success)
    end
  end

end
