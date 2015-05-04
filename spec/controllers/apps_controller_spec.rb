require 'rails_helper'

# require 'pp'

describe AppsController do
  before do
    @user = create(:user)
  end

  def token_header(token)
    request.env['HTTP_AUTHORIZATION'] =
    ActionController::HttpAuthentication::Token.encode_credentials(token)
  end

  describe 'Application#create' do
    it 'creates when authenticated' do
      post :create, 'Authorization' => token_header(@user.token),
                    app: { domain: 'www.example.com' }
      # pp 'Authorization' => token_header(@user.token)
      expect(response.status).to eq(201)
      assert_equal Mime::JSON, response.content_type
    end

    it 'fails without authentication' do
      post :create, app: { domain: 'www.example.com' }
      expect(response).to_not be_success
    end
  end

  describe 'Application#destroy' do
    before do
      @app = create(:app, user: @user)
    end

    it 'destroys when authenticated' do
      delete :destroy, 'Authorization' => token_header(@user.token), id: @app.id
      expect(response.status).to eq(204)
    end

    it 'fails without authentication' do
      delete :destroy, id: @app.id
      expect(response.status).to eq(401)
    end
  end

  describe 'Application#show' do
    before do
      @app = create(:app, user: @user)
    end

    it 'returns application' do
      get :show, 'Authorization' => token_header(@user.token), id: @app.id
      expect(response.status).to eq(200)
      assert_equal Mime::JSON, response.content_type
    end
  end
end
