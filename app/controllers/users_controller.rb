class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      # Set the session for the newly created user.
      # User will be "logged in".
      session[:user_id] = @user.id
      redirect_to root_url, :notice => "You are signed up."
    else
      render :new
    end
  end

  def activity
    @lends = current_user.lends
    @returns = current_user.returns
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @lends }
    end
  end
end