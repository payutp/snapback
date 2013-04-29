class ReturnsController < ApplicationController
  # GET /returns
  # GET /returns.json
  def index
    @returns = Return.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @returns }
    end
  end

  # GET /returns/1
  # GET /returns/1.json
  def show
    @return = Return.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @return }
    end
  end

  # GET /returns/new
  # GET /returns/new.json
  def new
    @lend = nil
    if params.has_key?("id")
      @lend = Lend.find(params[:id])
    end
    @return = Return.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @return }
    end
  end

  # GET /returns/1/edit
  def edit
    @return = Return.find(params[:id])
  end

  # POST /returns
  # POST /returns.json
  def create
    @return = current_user.returns.create(params[:return])
    dateTime = DateTime.new(params[:date][:year].to_i, params[:date][:month].to_i, params[:date][:day].to_i)
    @reminder = @return.build_reminder(:return_date => dateTime, :frequency => params[:frequency])

    # need to take care of the case where item not existed yet
    @return.item = Item.find(params[:item_id])
    @return.status = "lent"
    @return.to_id = @return.item.lend.user_id

    respond_to do |format|
      if @return.save and @reminder.save
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
    @return.destroy

    respond_to do |format|
      format.html { redirect_to returns_url }
      format.json { head :no_content }
    end
  end
end
