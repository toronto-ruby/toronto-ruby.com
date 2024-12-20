require 'test_helper'

class CalendarTest < ActiveSupport::TestCase
  def setup
    @event = Event.create(
      'name' => 'Witty Event Name',
      'location' => '<div>Some Office</div>',
      'rsvp_link' => 'https://test.com',
      'description' => '<div>DESCRIPTION</div>',
      'sponsor' => '',
      'sponsor_link' => '',
      'sponsor_logo' => '',
      'start_at' => '2024-11-26T00:30Z',
      'status' => 'published'
    )
    @calendar = Calendar.new([@event])
  end

  test 'ical_time produces the correct time' do
    want = DateTime.parse('2024-11-25T19:30-05:00').to_i
    # Yes, we're testing a private method...
    got = @calendar.send(:ical_time, @event.start_at).to_i
    assert_same(want, got)
  end
end
