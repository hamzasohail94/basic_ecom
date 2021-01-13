class ApplicationController < ActionController::Base
  helper_method :current_user

  private

  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    else
      @current_user = nil
    end
  end

  def authenticate_user
    unless session[:user_id]
      redirect_to users_signin_path
    end
  end
end
