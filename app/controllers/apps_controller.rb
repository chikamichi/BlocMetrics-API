class AppsController < ApplicationController
  before_action :authenticated?

  def show
    app = App.find(params[:id])

    render json: app.events
  end

  def create
    app = App.new(app_params)

    if app.save
      render json: app, status: 201
    else
      render json: {}, status: 422
    end
  end

  def destroy
    app = App.find(params[:id])

    if app.destroy
      render json: {}, status: 204
    else
      render json: {}, status: 404
    end
  end

  private

  def app_params
    params.require(:app).permit(:domain)
  end
end
