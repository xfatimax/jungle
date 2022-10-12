class SessionsController < ApplicationController
  
  def new
  end

  def create
    user = User.find_by_email(params[:email])
    # If the user exists and the password is correct
    if user && user.authenticate(params[:password])
      # Save the user id inside the browser cookie. This is how we keep the user logged in when navigating the jungle
      session[:user_id] = user.id
      redirect_to '/'
    else
      # If user's login doens't work, send them back to the login form
      redirect_to '/login'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/login'
  end
end