include ActionController::HttpAuthentication::Token::ControllerMethods

class ApplicationController < ActionController::API
  attr_reader :current_user
  include Pundit

  rescue_from ActionController::UnpermittedParameters do |parameter_unpermitted_exception|
    render json:
    { "error": "Unpermitted parameter: #{parameter_unpermitted_exception}" }, status: :bad_request
  end

  protected

  def authenticated?
    return true if request.method == 'OPTIONS'
    authenticate_or_request_with_http_token do |token|
      @current_user = User.find_by(token: token)
    end
  end
end
