require 'rails_helper'

describe ApplicationsController do 

  before do
    @user = create(:user)
  end

  def token_header(token)
    ActionController::HttpAuthentication::Token.encode_credentials(token)
  end

  describe "Application#create" do

    it "creates list when authenticated" do
      post :create, { 'Authorization' => token_header(@user.token) }, application: { domain: "www.example.com" }
      expect(response.status).to eq(201)
      assert_equal Mime::JSON, response.content_type
    end

    it "fails without authentication" do
      post :create, application: { domain: "www.example.com" }
      expect(response).to_not be_success
    end
  end
end