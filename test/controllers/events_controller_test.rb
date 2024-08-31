require "test_helper"

class EventsControllerTest < ActionController::TestCase
  def setup
    Event.destroy_all
    begining = Date.parse("2024-01-01").beginning_of_year
    dates = 12.times.map { |i| begining + i.months + rand(1..10).days }
    @events = dates.map { |date| Event.create!(start_at: date, name: "Toronto.rb #{date.strftime("%B %Y")}", location: "Toronto, Canada", presentation: "Presentation #{date}") }
  end

  test "all events in ics format" do
    get :all, format: :ics
    assert_response :success
    assert_equal "text/calendar; charset=utf-8", response.content_type

    calendar = Icalendar::Calendar.parse(response.body).first
    events = calendar.events

    assert_equal 12, events.count
    assert_equal @events.map(&:start_at).map(&:to_date).sort, events.map(&:dtstart).map(&:to_date).sort
    assert_equal @events.map(&:start_at).map { |date| "Toronto.rb #{date.strftime("%B %Y")}" }, events.map(&:summary)
    assert_equal @events.map(&:id).map { |id| "https://toronto-ruby.com/events/#{id}" }, events.map(&:url).map(&:to_s)
    assert_equal ["Toronto, Canada"], events.map(&:location).uniq
    assert_equal ["EST", "EST", "EST", "EDT", "EDT", "EDT", "EDT", "EDT", "EDT", "EDT", "EST", "EST"], events.map(&:dtstart).map(&:zone)
  end
end
