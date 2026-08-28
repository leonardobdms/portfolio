# frozen_string_literal: true

require "rails_helper"

RSpec.describe ContactMailer, type: :mailer do
  describe "#new_message" do
    let(:profile) { create(:profile, email: "owner@example.com") }
    let(:contact) { create(:contact) }

    def stub_from(value = :missing)
      allow(ENV).to receive(:fetch).and_wrap_original do |original, key, *args|
        next original.call(key, *args) unless key == "MAILER_FROM"

        value == :missing ? args.fetch(0, "noreply@localhost") : value
      end
    end

    before { profile }

    it "delivers a branded multipart message to the profile owner" do
      stub_from
      mail = ContactMailer.new_message(contact)
      html = mail.html_part.body.to_s
      text = mail.text_part.body.to_s
      admin_url = "http://example.com/admin/resources/contacts/#{contact.to_param}"

      expect(mail.to).to eq([ "owner@example.com" ])
      expect(mail.from).to eq([ "noreply@localhost" ])
      expect(mail.reply_to).to eq([ contact.email ])
      expect(mail.subject).to include(contact.subject)
      expect(mail.content_type).to include("multipart/alternative")

      expect(html).to include(contact.name)
      expect(html).to include(contact.email)
      expect(html).to include(contact.subject)
      expect(html).to include(contact.message)
      expect(html).to include(admin_url)
      expect(html).to include(profile.name)
      expect(html).to include("#0B1120")
      expect(html).to include("#6366F1")
      expect(html).to include(I18n.t("contact.mailer.heading"))
      expect(html).to include(%(role="presentation"))
      expect(html).to include("Helvetica, Arial, sans-serif")
      expect(html).not_to include("&#39;")
      expect(html).not_to include("var(--")
      expect(html).not_to include("<script")

      expect(text).to include(contact.name)
      expect(text).to include(contact.email)
      expect(text).to include(contact.message)
      expect(text).to include(admin_url)
      expect(text).to include(profile.name)
    end

    it "sends from MAILER_FROM when set" do
      stub_from("from@example.com")
      mail = ContactMailer.new_message(contact)

      expect(mail.from).to eq([ "from@example.com" ])
    end

    it "sends with no recipient when there is no profile" do
      Profile.delete_all
      mail = ContactMailer.new_message(contact)

      expect(mail.to).to be_nil
      expect(mail.html_part.body.to_s).to include(I18n.t("app.name"))
      expect(mail.text_part.body.to_s).to include(I18n.t("app.name"))
    end
  end
end
