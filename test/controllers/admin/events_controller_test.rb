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
        description: "Presentation #{date}",
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

  test 'index should show draft events' do
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

  test 'should show a single event' do
    get admin_event_path(Event.first.slug),
        headers: {
          Authorization:
            ActionController::HttpAuthentication::Basic.encode_credentials(
              'admin', 'admin'
            )
        }

    assert_response :ok
    assert response.body.include?(Event.first.name)
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

  test 'edit form should show all fields for the event' do
    # This test also tests that the form is keeping up with
    # our model's attributes.
    get admin_event_path(Event.first.slug),
        headers: {
          Authorization:
            ActionController::HttpAuthentication::Basic.encode_credentials(
              'admin', 'admin'
            )
        }

    # Get all attributes and rich text associations
    editable = Event.rich_text_association_names.map { |assoc|
      assoc.to_s.gsub('rich_text', 'event')
    } + Event.attribute_names.map do |attr|
      "event_#{attr}"
    end
    # Remove meta attributes we don't edit via the form
    editable -= %w[event_id event_slug event_city event_created_at event_updated_at]

    # Form fields we expect
    want = %w[event_name event_location event_link event_description event_sponsor event_sponsor_link
              event_sponsor_logo event_start_at event_status]
    assert_equal(want.length, editable.length)

    want.each do |attr|
      css_select "##{attr}"
    end
  end
end
