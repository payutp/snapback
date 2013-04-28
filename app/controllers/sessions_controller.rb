class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:email])

    # Authenticate method provided by has_secure_password
    # on the user class.

    if user && user.authenticate(params[:password])
      # Set the session for the logged in user.
	    if user.verified
	    	session[:user_id] = user.id
      		redirect_to root_url, :notice => "Logged in"
		else 
			flash.now.alert = "You did not verify your account! Please check your email."
			render "new"
		end
    else
      flash.now.alert = "Invalid email or password"
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice=> "Logged out"
  end
end