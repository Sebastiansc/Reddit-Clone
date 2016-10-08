class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user

  def current_user
    @current_user ||= User.find_by(session_token: session[:session_token])
    @current_user ? @current_user : nil
  end

  def login(user)
    session[:session_token] = user.session_token
  end

  def logout!
    user = current_user
    user.reset_session_token!
    session[:session_token] = nil
  end

  def ensure_ownership
    user = User.find(params[:id])
    if current_user.id != user.id
      redirect_to root_url
    end
  end

end
