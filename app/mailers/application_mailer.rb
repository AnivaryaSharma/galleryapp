class ApplicationMailer < ActionMailer::Base
  default from: "from@example.com"
  layout "mailer"

  def welcome_email(user)
    @user = user
    mail(to: user.email, subject:"Successfully Created an Album")
  end
end
