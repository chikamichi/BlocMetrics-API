require 'rails_helper'

require 'pp'

describe EventsController do

  before do
    @user = create(:user)
  end

  def token_header(token)
    request.env['HTTP_AUTHORIZATION'] =
    ActionController::HttpAuthentication::Token.encode_credentials(token)
  end

  context 'With existing App' do

    before do
      @app = create(:app, user: @user)
    end

    describe 'Events#create' do

      it 'creates when authenticated' do
        post :create, 'Authorization' => token_header(@user.token),
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

      it 'fails without authentication' do
        post :create, 'Authorization' => token_header('fake'),
                      event:
                      {
                        domain: 'example.com',
                        event: 'pageview',
                        url: 'example.com/about',
                        ip_address: '123456'
                      }
        expect(response.status).to eq(401)
      end
    end
  end

  context 'Without existing App' do
    describe 'Events#create' do

      it 'creates when authenticated' do
        post :create, 'Authorization' => token_header(@user.token),
                      event:
                      {
                        domain: 'example.org',
                        event: 'pageview',
                        url: 'example.com/about',
                        ip_address: '123456'
                      }
        expect(response.status).to eq(201)
        assert_equal Mime::JSON, response.content_type
      end

      it 'fails without authentication' do
        post :create, 'Authorization' => token_header('fake'),
                      event:
                      {
                        domain: 'example.org',
                        event: 'pageview',
                        url: 'example.com/about',
                        ip_address: '123456'
                      }
        expect(response.status).to eq(401)
      end
    end
  end
end
