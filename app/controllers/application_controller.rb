class ApplicationController < ActionController::Base
  helper_method :current_user, :signed_in?

  private

  def current_user
    return @current_user if defined?(@current_user)

    token = session[:session_token]
    @current_user = token && User.where(session_token: token).sole
  rescue ActiveRecord::RecordNotFound
    @current_user = nil
  end

  def signed_in?
    current_user.present?
  end

  def authenticate_admin!
    return if signed_in?

    session[:return_to] = request.fullpath if request.get?
    redirect_to login_path, alert: 'Please sign in to continue.'
  end
end
