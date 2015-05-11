class AppsController < ApplicationController
  before_action :authenticated?

  def index
    apps = current_user.apps
    authorize apps

    render json: apps
  end

  def show
    app = App.find(params[:id])
    authorize app

    sorted = app.events.group(:event).count
    events_count = []

    sorted.each do |key, value|
      events_count.push([key, value])
    end

    render json: { data: events_count }
  end

  def create
    app = App.new(app_params)
    authorize app

    if app.save
      render json: app, status: 201
    else
      render json: {}, status: 422
    end
  end

  def destroy
    app = App.find(params[:id])
    authorize app

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
