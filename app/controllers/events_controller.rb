class EventsController < ApplicationController
  before_action :authenticated?

  def create
    app = App.find(params[:app_id])
    event = app.events.build(event_params)
    authorize event

    if event.save
      render json: event, status: 201
    else
      render json: {}, status: 422
    end
  end

  private

  def event_params
    params.require(:event).permit(:domain, :event, :url, :ip_address)
  end
end
