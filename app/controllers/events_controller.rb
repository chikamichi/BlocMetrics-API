class EventsController < ApplicationController
  before_action :authenticated?

  def create
    event_data = event_params
    domain = event_data[:domain]
    app = App.find_or_initialize_by(domain: domain)
    app.update_attribute(:user_id, current_user.id) if app.new_record?
    event = app.events.build(event_data)
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
