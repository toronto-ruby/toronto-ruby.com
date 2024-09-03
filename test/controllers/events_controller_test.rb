require "test_helper"

class EventsControllerTest < ActionController::TestCase
  def setup
    Event.destroy_all
    begining = Date.parse("2024-01-01").beginning_of_year
    dates = 12.times.map { |i| begining + i.months + rand(1..10).days }
    @events = dates.map { |date| Event.create!(start_at: date, name: "Event #{date.strftime("%B %Y")}", location: "Some Office", city: "Toronto, Canada", presentation: "Presentation #{date}", status: :published) }
  end

  test "all events in ics format" do
    get :all, format: :ics
    assert_response :success
    assert_equal "text/calendar; charset=utf-8", response.content_type

    calendar = Icalendar::Calendar.parse(response.body).first
    events = calendar.events

    assert_equal 12, events.count
    assert_equal @events.map(&:start_at).map(&:to_date).sort, events.map(&:dtstart).map(&:to_date).sort
    assert_equal @events.map(&:start_at).map { |date| "Toronto Ruby - Event #{date.strftime("%B %Y")}" }, events.map(&:summary)
    assert_equal @events.map(&:slug).map { |slug| "http://test-env.toronto-ruby.com:3000/events/#{slug}" }, events.map(&:url).map(&:to_s)
    assert_equal ["Toronto, Canada"], events.map(&:location).uniq
    assert_equal ["EST", "EST", "EST", "EDT", "EDT", "EDT", "EDT", "EDT", "EDT", "EDT", "EST", "EST"], events.map(&:dtstart).map(&:zone)
  end

  test "shouldn't show draft events" do
    Event.update_all(status: :draft)

    get :all, format: :ics
    assert_response :success
    assert_equal "text/calendar; charset=utf-8", response.content_type

    calendar = Icalendar::Calendar.parse(response.body).first
    events = calendar.events

    assert_equal 0, events.count
  end
end
