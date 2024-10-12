class EventsController < ApplicationController
  # GET /events
  def index
    @events = Event.with_all_rich_text.upcoming
  end

  # GET /events/all or /events/all.ics
  def all
    @events = Event.with_all_rich_text.published.order(start_at: :desc)

    respond_to do |format|
      format.html { render :index }
      format.ics { render plain: Calendar.new(@events.order(start_at: :asc)).to_ical }
    end
  end

  def show
    @event = Event.with_all_rich_text.find_by!(slug: params[:slug])
  rescue ActiveRecord::RecordNotFound
    redirect_to all_events_path, error: 'Event not found'
  end

  def past
    @events = Event.with_all_rich_text.past
    render :index
  end

  def next
    @events = Event.with_all_rich_text.upcoming.first
    render :index
  end
end
