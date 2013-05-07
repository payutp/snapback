class UsersController < ApplicationController

  before_filter :load_user_using_perishable_token, :only => [:show]

  def new
    @user = User.new
  end

  def update
    respond_to do |format|
      if current_user.update_attributes(params[:user])
        format.html { redirect_to current_user, notice: 'Your photo has been updated.' }
        format.json { head :no_content }
      end
    end
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
      redirect_to login_path, :notice => "Thank you for verifying your account. You may now login."
    else
      @user = User.find(params[:id])
      @lends_close = @user.lends.where("status = 'close'")

      @returns_open = @user.returns.where("status = 'open'")
      @returns_lent = @user.returns.where("status = 'lent'")
      @returns_returned = @user.returns.where("status = 'returning'")
      @returns_close = @user.returns.where("status = 'close'")

      @user_rating = @user.rating
    end
  end

  def activity
    @lends = current_user.lends.where("status = 'pending'")
    @lends_pending = current_user.lends.where("status = 'pending'")
    @lends_close = current_user.lends.where("status = 'close'")

    @returns_open = current_user.returns.where("status = 'open'")
    @returns_lent = current_user.returns.where("status = 'lent'")
    @returns_returned = current_user.returns.where("status = 'returning'")
    @returns_close = current_user.returns.where("status = 'close'")
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @lends }
    end
  end

	private  
	def load_user_using_perishable_token  
		@user = User.where("perishable_token = ?", params[:id])[0]
		flash[:notice] = "Unable to find your account." unless @user or current_user
	end

end