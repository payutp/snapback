class ReturnsController < ApplicationController
  
  # get all returns
  def index
    @returns = Return.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @returns }
    end
  end

  # show a return
  def show
    @return = Return.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @return }
    end
  end

  # get a form for new return request
  def new
    @people = User.where("id != ?", current_user.id).order("email") # for email autocomplete
    @lend = nil
    if params.has_key?("id") # check if this is an independent return request,
      # or this is a return request generated from an accept button
      @lend = Lend.find(params[:id])
    end
    @return = Return.new

    respond_to do |format|
      format.js {}
      #format.html # new.html.erb
      #format.json { render json: @return }
    end
  end

  # GET /returns/1/edit
  def edit
    @return = Return.find(params[:id])
  end

  # create a new return, and generate a new reminder
  def create
    @return = current_user.returns.create(params[:return])
    dateTime = DateTime.strptime(params[:return_date], '%m/%d/%Y')

    # generate a new reminder based on date and time
    @reminder = @return.build_reminder(:return_date => dateTime, :frequency => params[:frequency])

    @return.item = Item.find(params[:item_id]) # setting return.item to an appropriate item
    @return.status = "lent" # set the return status after return request is generated
    @return.to_id = @return.item.lend.user_id

    respond_to do |format|
      if @return.save and @reminder.save
        ReminderMailer.accept_email(@reminder).deliver # send an accept email
        ReminderMailer.reminder_email(@reminder).deliver
        lend = @return.item.lend
        lend.update_attributes({:status => "pending", :to_id => current_user.id})

        format.html { redirect_to "/activity", notice: 'Return was successfully created.' }
        format.json { render json: @return, status: :created, location: @return }
      else
        format.html { render action: "new" }
        format.json { render json: @return.errors, status: :unprocessable_entity }
      end
    end
  end

  # create a return request independently. A new item object also needs to be created
  def create_new
    to = User.where("email = ?",params[:to_email])[0]
    @return = current_user.returns.create({:to_id => to.id})
    
    dateTime = DateTime.strptime(params[:return_date], '%m/%d/%Y')
    @reminder = @return.build_reminder(:return_date => dateTime, :frequency => params[:frequency])

    # need to take care of the case where item not existed yet
    @return.item = Item.new(:name => params[:item_name])
    @return.status = "lent"

    respond_to do |format|
      if @return.save and @reminder.save
        ReminderMailer.reminder_email(@reminder).deliver # send an email to the borrower
        lend = to.lends.create(:to_id => current_user.id, :status => "pending")
        lend.item = Item.find(@return.item.id)
        lend.save
        format.html { redirect_to "/activity", notice: 'Return was successfully created.' }
        format.json { render json: @return, status: :created, location: @return }
      else
        format.html { render action: "new" }
        format.json { render json: @return.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /returns/1
  # PUT /returns/1.json
  def update
    @return = Return.find(params[:id])

    respond_to do |format|
      if @return.update_attributes(params[:return])
        format.html { redirect_to @return, notice: 'Return was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @return.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /returns/1
  # DELETE /returns/1.json
  def destroy
    @return = Return.find(params[:id])
    if @return.item.lend
      @return.item.lend.destroy
    end
    @return.destroy

    respond_to do |format|
      format.html { redirect_to activity_path }
      format.json { head :no_content }
    end
  end
end
