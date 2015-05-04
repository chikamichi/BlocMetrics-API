require 'rails_helper'

require 'pp'

describe AppsController do
  before do
    @user = create(:user)
  end

  def token_header(token)
    request.env['HTTP_AUTHORIZATION'] =
    ActionController::HttpAuthentication::Token.encode_credentials(token)
  end

  describe 'Apps#create' do
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

  describe 'Apps#destroy' do
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

  describe 'Apps#show' do
    before do
      @app = create(:app, user: @user)
    end

    it 'returns application' do
      get :show, 'Authorization' => token_header(@user.token), id: @app.id
      expect(response.status).to eq(200)
      assert_equal Mime::JSON, response.content_type
    end
  end

  describe 'Apps#index' do
    before do
      @app = create(:app, user: @user)
    end

    it 'returns users applications' do
      get :index, 'Authorization' => token_header(@user.token)
      expect(response.status).to eq(200)
      assert_equal Mime::JSON, response.content_type
      JSON.parse(response.body).tap do |json|
        expect(json.length).to equal(1)
        expect(json.first["id"]).to equal @app.id
      end
    end
  end
end
