class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def require_user
    redirect_to login_page_path if not logged_in?
  end

  def current_user
    @current_user ||= find_current_user
  end
  helper_method :current_user

  def logged_in?
    current_user.present?
  end
  helper_method :logged_in?

  private

  def find_current_user
    if session[:user_id]
      User.find(session[:user_id])
    elsif cookies.signed['remember_user_token']
      user = User.from_cookie(cookies.signed['remember_user_token'])
      session[:user_id] = user.id
      user
    end
  rescue ActiveRecord::RecordNotFound
    session[:user_id] = nil
    cookies.delete('remember_user_token')
    nil
  end
end
