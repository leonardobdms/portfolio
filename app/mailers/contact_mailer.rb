# frozen_string_literal: true

class ContactMailer < ApplicationMailer
  def new_message(contact)
    @contact = contact
    profile = Profile.current

    mail(
      to: profile&.email,
      subject: I18n.t("contact.mailer.subject", subject: contact.subject)
    )
  end
end
