class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user
 
  def current_user
    begin
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    rescue
      @current_user = nil
      session[:user_id] = nil
    end
  end
end