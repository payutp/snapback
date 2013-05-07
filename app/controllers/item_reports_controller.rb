class ItemReportsController < ApplicationController
  # GET /item_reports
  # GET /item_reports.json
  def index
    @item_reports = ItemReport.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @item_reports }
    end
  end

  # GET /item_reports/1
  # GET /item_reports/1.json
  def show
    @item_report = ItemReport.find(params[:id])

    respond_to do |format|
      format.js {}
      #format.html # show.html.erb
      #format.json { render json: @item_report }
    end
  end

  # GET /item_reports/new
  # GET /item_reports/new.json
  def new
    @item = Item.find(params[:id])
    @item_report = ItemReport.new

    respond_to do |format|
      format.js {}
      #format.html # new.html.erb
      #format.json { render json: @item_report }
    end
  end

  # GET /item_reports/1/edit
  def edit
    @item_report = ItemReport.find(params[:id])
  end

  # POST /item_reports
  # POST /item_reports.json
  def create
    @item_report = ItemReport.new(:item_id => params[:item_id], :user_id=>current_user.id, :description => params[:description])

    respond_to do |format|
      if @item_report.save
        format.html { redirect_to request.referer, notice: 'Item report was successfully created.' }
        format.json { render json: @item_report, status: :created, location: @item_report }
      else
        format.html { render action: "new" }
        format.json { render json: @item_report.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /item_reports/1
  # PUT /item_reports/1.json
  def update
    @item_report = ItemReport.find(params[:id])

    respond_to do |format|
      if @item_report.update_attributes(params[:item_report])
        format.html { redirect_to @item_report, notice: 'Item report was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @item_report.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /item_reports/1
  # DELETE /item_reports/1.json
  def destroy
    @item_report = ItemReport.find(params[:id])
    @item_report.destroy

    respond_to do |format|
      format.html { redirect_to item_reports_url }
      format.json { head :no_content }
    end
  end
end
