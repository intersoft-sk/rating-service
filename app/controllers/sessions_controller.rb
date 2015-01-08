class SessionsController < ApplicationController
  # user shouldn't have to be logged in before logging in!
  skip_before_filter :set_current_user
  def create  
#  debugger  
    auth=request.env["omniauth.auth"]
    user=Owner.find_by_provider_and_uid(auth["provider"],auth["uid"]) ||
        Owner.create_with_omniauth(auth)
    session[:user_id] = user.id
    redirect_to ratings_path
  end
  def destroy
    session.delete(:user_id)
    flash[:notice] = 'Logged out successfully.'
    redirect_to ratings_path
  end
  def failure
    flash[:notice] = 'Failed authentication, please try again!'
    redirect_to ratings_path
  end
end