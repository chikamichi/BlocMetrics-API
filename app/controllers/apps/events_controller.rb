module Apps
  class EventsController < ApplicationController
    before_action :authenticated?

    def create
      app = App.find(params[:app_id])
      if app.user == current_user
        event = app.events.build(event_params)
        if event.save
          render json: event, status: 201
        else
          render json: {}, status: 422
        end
      else
        render json: {}, status: 401
      end
    end

    private

    def event_params
      params.require(:event).permit(:domain, :event, :url, :ip_address)
    end
  end
end
