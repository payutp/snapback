class UserReportsController < ApplicationController

  # show a report of a user 
  def show
    # user_report shows the report on specified user made by you (current_user)
    @user_report = current_user.user_reports.where(:reported_user => params[:reported_id]).first

    respond_to do |format|
      format.js {}
      #format.html # show.html.erb
      #format.json { render json: @user_report }
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

  # generate a new report for the user with reported_id
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
