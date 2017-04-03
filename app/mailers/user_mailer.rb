class UserMailer < ApplicationMailer
  default from: 'share.mma@fh-salzburg.ac.at'

  def confirm_email(user)
    @user = user
    @url = user_reopen_url(@user)
    mail(to: @user.email, subject: 'Bestätigungsmail: MultiMediaArt-Bachelor Upload Bewerbungsprojekt')
  end
end
