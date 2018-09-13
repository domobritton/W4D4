class ApplicationController < ActionController::Base
  helper_method :logged_in?
  helper_method :current_user

  def login!(user)
    @current_user = user
    session[:session_token] = user.reset_session_token!
  end

  def current_user
    return nil unless session[:session_token]
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def require_login
    redirect_to new_session_url unless logged_in?
  end

  def logged_in?
    !!current_user
  end

  def logged_out?
    current_user.reset_session_token!
    session[:session_token] = nil
  end

  def require_logout
    redirect_to new_session_url if logged_out?
  end

end
