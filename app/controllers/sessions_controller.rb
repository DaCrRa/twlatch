class SessionsController < ApplicationController
  def create
    user = User.create_from_twitter_auth(env["omniauth.auth"])
    session[:user_id] = user.id
    redirect_to root_path
  end
 
  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

end