class ContactFormMailer < ActionMailer::Base

  default :from => "webmaster@impulsideas.com"

  def notification_email(user)
    @user = user
    mail(to: "email@impulsideas.com",
      subject: "#{user.name} - Impulsideas Landing Page",
      body: "Email: #{user.email}\r\n<br>Nombre:#{user.name}\r\n<br>Mensaje#{user.message}",
      from: "#{user.name} <#{user.email}>",
      reply_to: "#{user.name} <#{user.email}>")
  end
end
