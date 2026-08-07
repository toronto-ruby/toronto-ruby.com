require 'test_helper'

class EventsControllerTest < ActionController::TestCase
  def setup
    Event.destroy_all
    begining = Date.parse('2024-01-01').beginning_of_year
    dates = 12.times.map { |i| begining.to_datetime.change(hour: 19, zone: 'America/Toronto') + i.months }
    @events = dates.map do |date|
      Event.create!(
        start_at: date,
        name: "Event #{date.strftime('%B %Y')}",
        location: 'Some Office',
        city: 'Toronto, Canada',
        description: "Presentation #{date}",
        status: :published,
        sponsor: 'Some Sponsor',
        sponsor_link: 'https://example.com'
      )
    end
  end

  test 'all events in ics format' do
    get :all, format: :ics
    assert_response :success
    assert_equal 'text/calendar; charset=utf-8', response.content_type

    calendar = Icalendar::Calendar.parse(response.body).first
    events = calendar.events

    assert_equal 12, events.count
    assert_equal @events.map(&:start_at).map(&:to_date).sort, events.map(&:dtstart).map(&:to_date).sort
    assert_equal @events.map(&:start_at).map { |date|
      "Toronto Ruby - Event #{date.strftime('%B %Y')}"
    }, events.map(&:summary)
    assert_equal @events.map(&:slug).map { |slug|
      "http://test-env.toronto-ruby.com:3000/events/#{slug}"
    }, events.map(&:url).map(&:to_s)
    assert_equal ['Toronto, Canada'], events.map(&:location).uniq
    assert_equal %w[EST EST EST EDT EDT EDT EDT EDT EDT EDT EDT EST],
                 events.map(&:dtstart).map(&:zone)
  end

  test "shouldn't show draft events" do
    Event.update_all(status: :draft)

    get :all, format: :ics
    assert_response :success
    assert_equal 'text/calendar; charset=utf-8', response.content_type

    calendar = Icalendar::Calendar.parse(response.body).first
    events = calendar.events

    assert_equal 0, events.count
  end

  test 'should redirect to events page if event is not found' do
    get :show, params: { slug: 'nonexistent-event' }

    assert_response :found
    assert_redirected_to all_events_path
  end

  test 'links the location to Google Maps' do
    event = @events.first
    event.update!(location: "Workplace One\n51 Wolseley St, Toronto ON")

    get :show, params: { slug: event.slug }

    assert_response :success
    assert_match 'https://www.google.com/maps/search/?api=1&amp;query=Workplace+One%2C+51+Wolseley+St%2C+Toronto+ON',
                 response.body
    assert_match 'Open in Google Maps', response.body
  end

  test 'an event still in progress stays on the home page' do
    create_only_event('In Progress Event', Time.zone.now - 1.hour)

    get :index
    assert_response :success
    assert_match 'In Progress Event', response.body
    assert_match 'Upcoming', response.body

    get :past
    assert_response :success
    assert_match 'No past events', response.body
  end

  test 'an event that has ended moves to past events' do
    create_only_event('Finished Event', Time.zone.now - (Event::DURATION + 1.minute))

    get :index
    assert_response :success
    assert_match "We're planning our next outing", response.body

    get :past
    assert_response :success
    assert_match 'Finished Event', response.body
    assert_match 'Past Event', response.body
  end

  private

  def create_only_event(name, start_at)
    Event.destroy_all
    Event.create!(
      start_at: start_at,
      name: name,
      location: 'Some Office',
      description: 'A talk',
      status: :published,
      rsvp_link: 'https://example.com/rsvp',
      sponsor: 'Some Sponsor',
      sponsor_link: 'https://example.com'
    )
  end
end
