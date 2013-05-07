class UserReportsController < ApplicationController

  # GET /user_reports/1
  # GET /user_reports/1.json
  def show
    @user_report = UserReport.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user_report }
    end
  end

  # GET /user_reports/new
  # GET /user_reports/new.json
  def new
    @user = User.find(params[:reported_id])
    @user_report = UserReport.new

    respond_to do |format|
      format.js {}
      #format.html # new.html.erb
      #format.json { render json: @user_report }
    end
  end

  # POST /user_reports
  # POST /user_reports.json
  def create
    @user_report = UserReport.new(:reported_user => params[:reported_id], :user_id=>current_user.id, :description => params[:description])

    respond_to do |format|
      if @user_report.save
        format.html { redirect_to request.referer, notice: 'User report was successfully created.' }
        format.json { render json: @user_report, status: :created, location: @user_report }
      else
        format.html { render action: "new" }
        format.json { render json: @user_report.errors, status: :unprocessable_entity }
      end
    end
  end

end
