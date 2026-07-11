class SessionsController < ApplicationController
  rate_limit to: 10, within: 3.minutes, only: :create,
             with: -> { redirect_to login_path, alert: 'Too many attempts. Try again in a few minutes.' }

  def new; end

  def create
    user = User.authenticate_by(username: params[:username].to_s, password: params[:password].to_s)
    if user
      user.regenerate_session_token
      return_to = session[:return_to]
      reset_session
      session[:session_token] = user.session_token
      redirect_to(return_to || admin_events_path, notice: 'Signed in.')
    else
      flash.now[:alert] = 'Invalid username or password.'
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    current_user&.update!(session_token: nil)
    reset_session
    redirect_to login_path, notice: 'Signed out.'
  end
end
