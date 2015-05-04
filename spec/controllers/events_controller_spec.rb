require 'rails_helper'

require 'pp'

describe EventsController do

  before do
    @user = create(:user)
    @app = create(:app, user: @user)
  end

  def token_header(token)
    request.env['HTTP_AUTHORIZATION'] =
    ActionController::HttpAuthentication::Token.encode_credentials(token)
  end

  describe 'Events#create' do

    it 'creates when authenticated' do
      post :create, 'Authorization' => token_header(@user.token),
                    app_id: @app.id,
                    event:
                    {
                      domain: 'example.com',
                      event: 'pageview',
                      url: 'example.com/about',
                      ip_address: '123456'
                    }
      expect(response.status).to eq(201)
      assert_equal Mime::JSON, response.content_type
    end
  end
end
