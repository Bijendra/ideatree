class UserMailer < ApplicationMailer
  default from: 'admin@shoretel.com'
 
  def welcome_email(user)
    @user = user
    @url  = root_url
    mail(to: @user.email, subject: 'Welcome to Ideatree')
  end
end
