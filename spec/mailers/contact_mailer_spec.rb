# frozen_string_literal: true

require "rails_helper"

RSpec.describe ContactMailer, type: :mailer do
  describe "#new_message" do
    let(:profile) { create(:profile, email: "owner@example.com") }
    let(:contact) { create(:contact) }

    before { profile }

    it "delivers to the profile owner" do
      mail = ContactMailer.new_message(contact)

      expect(mail.to).to eq([ "owner@example.com" ])
      expect(mail.subject).to include(contact.subject)
      expect(mail.body.encoded).to include(contact.message)
    end
  end
end
