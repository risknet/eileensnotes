class CustomDeviseMailer < ActionMailer::Base
  default from: "eileensnotes@risknetlee.com"

  # add BCC for all emails sent out by Devise
  def headers_for(action, opts)
    if Rails.env.production?
      bcc_email = "eileensnotes@risknetlee.com"
    else
      bcc_email = "eileensnotes@risknetlee.com"
    end
    super.merge!({bcc: bcc_email})
  end

end
