class SessionsController < ApplicationController

  def new
  end

  def create
    # If the user exists AND the password entered is correct.
    if user = User.authenticate_with_credentials(params[:email], params[:password])
      # Save the user id inside the browser cookie. 
      session[:user_id] = user.id
      redirect_to :root
    else
    # If user's login doesn't work, send them back to the login form.
      render:new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to :root
  end

end