class UsersController < ApplicationController

  before_filter :load_user_using_perishable_token, :only => [:show]

  def new
    @user = User.new
  end

  # method for updating attributes of users, which can be profile picture, name, address, etc.
  def update
    respond_to do |format|
      if current_user.update_attributes(params[:user])
        format.html { redirect_to current_user, notice: 'Your photo has been updated.' }
        format.json { head :no_content }
      end
    end
  end

  # creating a user, along with perishable token for verification
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

  # method for showing a user, either after verification, or when viewing a profile page.
  # Two cases can be determined from @user variable
  def show
  	if @user
      @user.verify!
      redirect_to login_path, :notice => "Thank you for verifying your account. You may now login."
    else
      @user = User.find(params[:id])
      @user_rating = @user.rating
    end
  end

  # get lends and returns to view for activity page
  def activity

    # obtain variables corresponding to different statuses
    @lends_pending = current_user.lends.where("status='pending'")
    @tags_pending = []
      @lends_pending.each do |lend|
        @tags_pending << lend.item.tags
      end
    @lends_close = current_user.lends.where("status = 'close'")
    @tags_close = []
      @lends_close.each do |lend|
        @tags_close << lend.item.tags
      end

    @returns_lent = current_user.returns.where("status = 'lent'")
    @tags_lent = []
      @returns_lent.each do |lend|
        @tags_lent << lend.item.tags
      end
    @returns_returned = current_user.returns.where("status = 'returning'")
        @tags_returned = []
      @returns_returned.each do |lend|
        @tags_returned << lend.item.tags
      end
    @returns_close = current_user.returns.where("status = 'close'")
        @tags_rclose = []
      @returns_close.each do |lend|
        @tags_rclose << lend.item.tags
      end
    
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