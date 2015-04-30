class ApplicationsController < ApplicationController
  before_action :authenticated?

  def show
  end

  def create
    application = Application.new(application_params)

    if application.save
      render json: application, status: 201
    else 
      render json: {}, status: 422
    end
  end

  def destroy
  end

  private

  def application_params
    params.require(:application).permit(:domain)
  end
end