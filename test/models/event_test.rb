require 'test_helper'

class EventTest < ActiveSupport::TestCase
  def build_event(attributes = {})
    Event.new({
      name: 'Witty Event Name',
      location: "Workplace One\n51 Wolseley St, Toronto ON\nLower level, enter through doors on Wolseley St.",
      description: 'A talk',
      rsvp_link: 'https://test.com',
      status: :published,
      start_at: Time.zone.parse('2024-11-26T00:30Z')
    }.merge(attributes))
  end

  test 'end_at is three hours after start_at' do
    event = build_event(start_at: Time.zone.parse('2024-11-25T19:30-05:00'))

    assert_equal Time.zone.parse('2024-11-25T22:30-05:00'), event.end_at
  end

  test 'over? flips at the end time, not the start time' do
    event = build_event(start_at: Time.zone.now - 2.hours)
    assert_not event.over?

    event.start_at = Time.zone.now - 4.hours
    assert event.over?
  end

  test 'map_url builds a Google Maps search from the venue and street address' do
    event = build_event

    assert_equal 'https://www.google.com/maps/search/?api=1&query=Workplace+One%2C+51+Wolseley+St%2C+Toronto+ON',
                 event.map_url
  end

  test 'map_url appends the city when the address does not name it' do
    event = build_event(location: "FinanceIt @ The Well\n8 Spadina Ave\nSuite 2400", city: 'Toronto, Canada')

    assert_equal 'https://www.google.com/maps/search/?api=1&query=FinanceIt+%40+The+Well%2C+8+Spadina+Ave%2C+Toronto%2C+Canada',
                 event.map_url
  end

  test 'map_url is nil without a location' do
    assert_nil build_event(location: '').map_url
  end

  test 'an in-progress event is upcoming, not past' do
    Event.destroy_all
    event = build_event(start_at: Time.zone.now - 1.hour)
    event.save!

    assert_includes Event.upcoming, event
    assert_not_includes Event.past, event
  end

  test 'a finished event is past, not upcoming' do
    Event.destroy_all
    event = build_event(start_at: Time.zone.now - (Event::DURATION + 1.minute))
    event.save!

    assert_includes Event.past, event
    assert_not_includes Event.upcoming, event
  end
end
