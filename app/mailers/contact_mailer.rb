# frozen_string_literal: true

class ContactMailer < ApplicationMailer
  def new_message(contact)
    @contact = contact
    @admin_contact_url = admin_contact_url_for(contact)
    @preheader = I18n.t("contact.mailer.preheader", name: contact.name, subject: contact.subject)
    profile = Profile.current

    mail(
      to: profile&.email,
      reply_to: contact.email,
      subject: I18n.t("contact.mailer.subject", subject: contact.subject)
    )
  end

  private

  def admin_contact_url_for(contact)
    Avo::Engine.routes.url_helpers.resources_contact_url(
      id: contact.to_param,
      **default_url_options
    )
  end
end
