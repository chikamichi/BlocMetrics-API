include ActionController::HttpAuthentication::Token::ControllerMethods

class ApplicationController < ActionController::API
  attr_reader :current_user
  include Pundit

  rescue_from ActionController::UnpermittedParameters do |parameter_unpermitted_exception|
    render json: { "error": "Unpermitted parameter: #{parameter_unpermitted_exception}" }, status: :bad_request
  end

  # before_filter :cors_preflight_check
  # after_filter :cors_set_access_control_headers
  #
  # def cors_set_access_control_headers
  #   headers['Access-Control-Allow-Origin'] = '*'
  #   headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, DELETE, OPTIONS'
  #   headers['Access-Control-Allow-Headers'] = 'Origin, Content-Type, Accept, Authorization, Token'
  #   headers['Access-Control-Max-Age'] = '0'
  # end
  #
  # def cors_preflight_check
  #   if request.method == 'OPTIONS'
  #     headers['Access-Control-Allow-Origin'] = '*'
  #     headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, DELETE, OPTIONS'
  #     headers['Access-Control-Allow-Headers'] = 'Authorization, Token'
  #     headers['Access-Control-Max-Age'] = '0'
  #
  #     render text: '', content_type: 'text/plain'
  #   end
  # end

  protected

  def authenticated?
    return true if request.method == 'OPTIONS'
    authenticate_or_request_with_http_token do |token|
      @current_user = User.find_by(token: token)
    end
  end
end
