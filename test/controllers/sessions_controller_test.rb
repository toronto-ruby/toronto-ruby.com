require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  def setup
    User.destroy_all
    @admin = User.create!(username: 'trbadmin', password: 'admin')
  end

  test 'GET /login renders the form' do
    get login_path
    assert_response :success
    assert_select 'input[name=username]'
    assert_select 'input[name=password][type=password]'
  end

  test 'POST /login with valid credentials signs in and rotates session token' do
    original_token = @admin.session_token

    post login_path, params: { username: 'trbadmin', password: 'admin' }

    assert_redirected_to admin_events_path
    @admin.reload
    assert_not_equal original_token, @admin.session_token
  end

  test 'POST /login normalizes username case and whitespace' do
    post login_path, params: { username: ' TRBADMIN ', password: 'admin' }
    assert_redirected_to admin_events_path
  end

  test 'POST /login with wrong password re-renders' do
    post login_path, params: { username: 'trbadmin', password: 'nope' }
    assert_response :unprocessable_entity
  end

  test 'POST /login with unknown user re-renders' do
    post login_path, params: { username: 'nobody', password: 'admin' }
    assert_response :unprocessable_entity
  end

  test 'DELETE /logout clears session token and redirects' do
    post login_path, params: { username: 'trbadmin', password: 'admin' }
    delete logout_path

    assert_redirected_to login_path
    assert_nil @admin.reload.session_token
  end

  test 'unauthenticated request to admin redirects to login' do
    get admin_events_path
    assert_redirected_to login_path
  end
end
