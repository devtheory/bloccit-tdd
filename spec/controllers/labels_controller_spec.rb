require 'rails_helper'

RSpec.describe LabelsController, type: :controller do
  let(:label) { Label.create!(name: "Label")}

  describe "GET #show" do
    it "returns http success" do
      get :show, id: label.id
      expect(response).to have_http_status(:success)
    end
  end

end
