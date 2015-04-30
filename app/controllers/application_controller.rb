include ActionController::HttpAuthentication::Token::ControllerMethods

class ApplicationController < ActionController::API

  rescue_from ActionController::UnpermittedParameters do |parameter_unpermitted_exception|
    render json: {"error": "Unpermitted parameter: #{parameter_unpermitted_exception}"}, status: :bad_request
  end

  protected
  
  def authenticated?
    authenticate_or_request_with_http_token do |token|
      User.find_by(token: token)
    end
  end
end
