class ApplicationController < ActionController::API

  rescue_from ActionController::UnpermittedParameters do |parameter_unpermitted_exception|
    render json: {"error": "Unpermitted parameter: #{parameter_unpermitted_exception}"}, status: :bad_request
  end
end
