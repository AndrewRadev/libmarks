class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def log_in(user)
    session[:user_id] = user.id
  end

  def log_out
    session.delete(:user_id)
  end

  def current_user
    session[:user_id] and User.find_by(id: session[:user_id])
  end
  helper_method :current_user

  def logged_in?
    current_user
  end
  helper_method :logged_in?
end
