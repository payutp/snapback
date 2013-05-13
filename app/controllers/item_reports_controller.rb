class ItemReportsController < ApplicationController

  # show the report
  def show
    @item_report = current_user.item_reports.where(:item_id => params[:id]).first

    respond_to do |format|
      format.js {}
      #format.html # show.html.erb
      #format.json { render json: @item_report }
    end
  end

  # create a new report
  def new
    @item = Item.find(params[:id])
    @item_report = ItemReport.new

    respond_to do |format|
      format.js {}
      #format.html # new.html.erb
      #format.json { render json: @item_report }
    end
  end

  # create a new report
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
end
