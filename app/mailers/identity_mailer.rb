class IdentityMailer < ActionMailer::Base
  default from: Rails.application.secrets.email_ideaburn
  layout false

  def identity_confirmation(user)
    @user = user
    mail(to: Rails.application.secrets.email_ideaburn, subject: 'Request for verification of investor',template_path: 'identity_mailer',template_name: 'identity_email')
  end
end
