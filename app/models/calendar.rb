require "icalendar"

class Calendar
  def initialize(events)
    @events = events
  end

  def publish
    calendar = Icalendar::Calendar.new

    calendar.timezone do |timezone|
      timezone.tzid = timezone_identifier
    end

    @events.each do |event|
      calendar.event do |e|
        e.dtstart     = ical_time(event.start_at)
        e.dtend       = ical_time(event.start_at + 2.hours)
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

  private

  def timezone_identifier
    "America/Toronto"
  end

  def timezone
    @timezone ||= TZInfo::Timezone.get(timezone_identifier)
  end

  def ical_timezone
    timezone.ical_timezone(timezone.now)
  end

  def ical_time(datetime)
    Icalendar::Values::DateTime.new(datetime, tzid: timezone_identifier)
  end
end
