class UsersController < ApplicationController

  before_filter :load_user_using_perishable_token, :only => [:show]

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    @user.generate_perishable_token

    if @user.save
	  # Tell the UserMailer to send a verification email after save
      @user.deliver_verification_instructions!
      # Set the session for the newly created user.
      redirect_to root_url, :notice => "Check your email for verification."
    else
      render :new
    end
  end

  def show
  	if @user
      @user.verify!
      flash[:notice] = "Thank you for verifying your account. You may now login."
    end
    redirect_to login_path
  end

  def activity
    @lends = current_user.lends.where("status == 'pending'")
    #@returns_pending = current_user.returns.where("status = 'pending'")
    #@returns_returned = current_user.returns.where("status = 'returned'")
    #@returns_closed = current_user.returns.where("status = 'closed'")
    @returns = current_user.returns
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @lends }
    end
  end

	private  
	def load_user_using_perishable_token  
		@user = User.where("perishable_token = ?", params[:id])[0]
		flash[:notice] = "Unable to find your account." unless @user
	end

end