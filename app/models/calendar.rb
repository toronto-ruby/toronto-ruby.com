require "icalendar"

class Calendar
  def initialize(events)
    @events = events
  end

  def publish
    calendar = Icalendar::Calendar.new

    calendar.timezone do |timezone|
      timezone.tzid = "UTC"
    end

    @events.each do |event|
      calendar.event do |e|
        e.dtstart     = Icalendar::Values::DateTime.new(event.start_at.utc)
        e.dtend       = Icalendar::Values::DateTime.new((event.start_at + 2.hours).utc)
        e.summary     = event.name
        e.description = event.presentation
        e.location    = "Toronto, Canada" # TODO: Use event.location, but it's too long for the calendar with all the details and instructions
        e.url         = event.rsvp_link || "https://toronto-ruby.com/events/#{event.id}"
      end
    end

    calendar.publish
  end

  def to_ical
    publish.to_ical
  end
end
