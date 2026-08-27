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

    it "delivers to the profile owner" do
      stub_from
      mail = ContactMailer.new_message(contact)

      expect(mail.to).to eq([ "owner@example.com" ])
      expect(mail.from).to eq([ "noreply@localhost" ])
      expect(mail.subject).to include(contact.subject)
      expect(mail.body.encoded).to include(contact.message)
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
    end
  end
end
