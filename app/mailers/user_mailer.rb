class UserMailer < ActionMailer::Base
  default :from => "snapbackapp@gmail.com"
 
  def welcome_email(user)
    @user = user
    @url  = "http://example.com/login"
    mail(:to => user.email, :subject => "Welcome to SnapBack")
  end

  def verification_email(user)
  	@user = user
  	@url = user_url(user.perishable_token)
  	mail(	:to => user.email, 
  			:subject => "Welcome to SnapBack", 
  			:from => "SnapBack",
  			:body => user_url(user.perishable_token)
  		)
  end

end
