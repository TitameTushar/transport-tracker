class AdminMailer < ActionMailer::Base
  default from: "tushartitame@gmail.com"

  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: 'Thanks!for your registration!')
  end

   def notify_email(to,pos,user)
    @to = to
    @pos=pos
    @by=user
    mail(to: @to.email, subject: 'Your Bus Location Updated')
  end
end
