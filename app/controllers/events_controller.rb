class EventsController < ApplicationController
  # GET /events or /events.json
  def index
    @events = Event.upcoming
  end

  def all
    @events = Event.all
    render :index
  end

  def past
    @events = Event.past
    render :index
  end
end
