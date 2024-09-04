class EventsController < ApplicationController
  # GET /events
  def index
    @events = Event.upcoming
  end

  # GET /events/all or /events/all.ics
  def all
    @events = Event.published

    respond_to do |format|
      format.html { render :index }
      format.ics { render plain: Calendar.new(@events.order(start_at: :asc)).to_ical }
    end
  end

  def show
    @event = Event.find_by(slug: params[:slug])
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
