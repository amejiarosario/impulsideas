class ContactFormMailer < ActionMailer::Base

  default :from => "webmaster@impulsideas.com"

  def notification_email(user)
    @user = user
    mail(to: "adriansky@gmail.com", 
      subject: "#{user.name} - Impulsideas Landing Page", 
      body: user.message, 
      from: "#{user.name} <#{user.email}>",
      reply_to: "#{user.name} <#{user.email}>")
  end
end
