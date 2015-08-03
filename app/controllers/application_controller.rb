class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  #methods in application_controller are only available to other controllers
  #to make them available to view templates declare as helper_method
  helper_method :current_user, :logged_in?, :require_user

  #returns user object if there's an authenticated user, else returns nil
  def current_user
    # ||= is memorization, only hits db once per template, faster this way
    # if current_user exisits, don't execute User.find
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user #!! turns any object to boolean value
  end

  def require_user
    if !logged_in?
      flash[:error] = "Must be logged in to do that"
      redirect_to root_path
    end
  end
end
