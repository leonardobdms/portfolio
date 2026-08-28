# frozen_string_literal: true

require "rails_helper"

RSpec.describe Devise::Mailer, type: :mailer do
  it "wraps reset password instructions in the branded layout" do
    admin = create(:admin)
    mail = described_class.reset_password_instructions(admin, "reset-token")
    html = mail.html_part.body.to_s
    text = mail.text_part.body.to_s

    expect(mail.content_type).to include("multipart/alternative")
    expect(html).to include("#0B1120")
    expect(html).to include("#6366F1")
    expect(html).to include(I18n.t("mailer.view_site"))
    expect(html).to include(I18n.t("devise.mailer.reset_password_instructions.action"))
    expect(html).to include("reset-token")
    expect(text).to include("reset-token")
    expect(text).to include(I18n.t("devise.mailer.reset_password_instructions.heading"))
  end
end
