require 'icalendar'

class Calendar
  include Rails.application.routes.url_helpers

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
        e.dtend       = ical_time(event.start_at + 3.hours)
        e.summary     = "Toronto Ruby - #{event.name}"
        e.location    = event.city
        e.url         = event.rsvp_link || event_url(event)

        sponsor = event.sponsor ? <<~SPONSOR : nil
          Sponsor:
          #{event.sponsor} (#{event.sponsor_link})
        SPONSOR

        rsvp_link = event.rsvp_link ? <<~RSVP : nil
          RSVP:
          #{event.rsvp_link}
        RSVP

        e.description = <<~DESCRIPTION
          Toronto Ruby - #{event.name}
          #{event.description.to_plain_text}

          Location:
          #{event.location.to_plain_text}

          Event-Site:
          #{event_url(event)}

          #{rsvp_link}
          #{sponsor}
        DESCRIPTION
      end
    end

    calendar.publish
  end

  def to_ical
    publish.to_ical
  end

  private

  def timezone_identifier
    'America/Toronto'
  end

  def timezone
    @timezone ||= TZInfo::Timezone.get(timezone_identifier)
  end

  def ical_time(datetime)
    Icalendar::Values::DateTime.new(datetime.in_time_zone(timezone_identifier), tzid: timezone_identifier)
  end
end
