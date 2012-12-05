class Mailer < ActionMailer::Base
  default from: %Q|"#{I18n.t("app_name_with_kana")}" <noreply@funglish.jp>|

  def email_address_confirmation(email_address, root_url, facebook_id, email_address_confirmation_code)
    @root_url = root_url
    @facebook_id = facebook_id
    @email_address_confirmation_code = email_address_confirmation_code
    mail to: email_address
  end

  def schedule_applied(email_address, schedule_time, root_url, schedule_id)
    @schedule_time = schedule_time
    @root_url = root_url
    @schedule_id = schedule_id
    mail to: email_address
  end

  def schedule_approved(email_address, schedule_time, root_url, schedule_id)
    @schedule_time = schedule_time
    @root_url = root_url
    @schedule_id = schedule_id
    mail to: email_address
  end

  def schedule_comment_posted(email_address, schedule_time, root_url, schedule_id)
    @schedule_time = schedule_time
    @root_url = root_url
    @schedule_id = schedule_id
    mail to: email_address
  end
end
