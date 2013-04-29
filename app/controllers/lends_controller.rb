class LendsController < ApplicationController
  # GET /lends
  # GET /lends.json
  def index

    if current_user
      @lends_others = Lend.where("user_id != ? and status = 'open'", current_user.id)
      @lends_open = current_user.lends.where("status='open'")
      @lends_pending = current_user.lends.where("status='pending'")
    else
      @lends_others = Lend.where("status = 'open'")
      @lends = Lend.where("status = 'open'")
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @lends }
    end
  end

  # GET /lends/1
  # GET /lends/1.json
  def show
    @lend = current_user.lends.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @lend }
    end
  end

  # GET /lends/new
  # GET /lends/new.json
  def new
    @lend = current_user.lends.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @lend }
    end
  end

  # GET /lends/1/edit
  def edit
    @lend = current_user.lends.find(params[:id])
  end

  # POST /lends
  # POST /lends.json
  def create
    @lend = current_user.lends.new({:status => "open"})
    @lend.build_item({:name => params[:item_name], :lend_id => current_user.id})
    
    respond_to do |format|
      if @lend.save
        format.html { redirect_to lends_path, notice: 'Lend was successfully created.' }
        format.json { render json: @lend, status: :created, location: @lend }

      else
        format.html { render action: "new" }
        format.json { render json: @lend.errors, status: :unprocessable_entity }
      end
    end
  end


  # DELETE /lends/1
  # DELETE /lends/1.json
  def destroy
    @lend = current_user.lends.find(params[:id])
    @bad_return_request = @lend.item.return
    if @bad_return_request != nil 
      @bad_return_request.destroy
    end

    @lend.destroy

    respond_to do |format|
      format.html { redirect_to lends_url }
      format.json { head :no_content }
    end
  end
  
end
