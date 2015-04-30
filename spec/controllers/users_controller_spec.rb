require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe "POST #create" do
    it "returns http success" do
      post :create, user: { token: "1234abcd" }
      expect(response).to have_http_status(:success)
    end
  end

end
