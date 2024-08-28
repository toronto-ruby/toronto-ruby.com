class EventsController < ApplicationController
  # GET /events
  def index
    @events = Event.upcoming
  end

  # GET /events/all or /events/all.ics
  def all
    @events = Event.all

    respond_to do |format|
      format.html { render :index }
      format.ics { render plain: Calendar.new(@events).to_ical}
    end
  end

  def show
    @event = Event.find(params[:id])
  end

  def past
    @events = Event.past
    render :index
  end

  def next
    @events = Event.upcoming.first
    render :index
  end
end
