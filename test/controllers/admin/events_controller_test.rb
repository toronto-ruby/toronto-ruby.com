require 'test_helper'

class Admin::EventsControllerTest < ActionDispatch::IntegrationTest
  def setup
    Event.destroy_all
    begining = Date.parse('2024-01-01').beginning_of_year
    dates = 12.times.map { |i| begining + i.months }
    @events = dates.map do |date|
      Event.create!(
        start_at: date,
        name: "Event #{date.strftime('%B %Y')}",
        location: 'Some Office',
        city: 'Toronto, Canada',
        presentation: "Presentation #{date}",
        status: :published,
        sponsor: 'Some Sponsor',
        sponsor_link: 'https://example.com'
      )
    end
  end

  test 'should load the index page' do
    get admin_events_path,
        headers: {
          Authorization:
            ActionController::HttpAuthentication::Basic.encode_credentials(
              'admin', 'admin'
            )
        }

    assert_response :success
  end

  test 'should show draft events' do
    Event.update_all(status: :draft)

    get admin_events_path,
        headers: {
          Authorization:
            ActionController::HttpAuthentication::Basic.encode_credentials(
              'admin', 'admin'
            )
        }

    assert_response :success
    assert_equal 'text/html; charset=utf-8', response.content_type
    assert response.body.include?(Event.last.name)
  end

  test 'should redirect to events page if event is not found' do
    get admin_event_path('nonexistent-event'),
        headers: {
          Authorization:
            ActionController::HttpAuthentication::Basic.encode_credentials(
              'admin', 'admin'
            )
        }

    assert_response :redirect
    assert_redirected_to admin_events_path
  end
end
