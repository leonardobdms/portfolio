# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Contacts", type: :request do
  let!(:profile) { create(:profile, email: "owner@example.com") }

  describe "POST /contacts" do
    it "creates a message and redirects with notice" do
      expect {
        post contacts_path, params: {
          name: "Jane Doe",
          email: "jane@example.com",
          subject: "Hello",
          message: "I want to work with you on a project.",
          "cf-turnstile-response" => "valid-token"
        }
      }.to change(Contact, :count).by(1)

      expect(response).to redirect_to(root_path(anchor: "contact"))
      follow_redirect!
      expect(inertia).to have_flash(notice: I18n.t("contact.success"))
    end

    it "redirects with validation errors" do
      post contacts_path, params: {
        name: "",
        email: "invalid",
        subject: "",
        message: "short",
        "cf-turnstile-response" => "valid-token"
      }

      expect(response).to redirect_to(root_path(anchor: "contact"))
      follow_redirect!
      expect(inertia).to have_props(
        errors: {
          name: "Name can't be blank",
          email: "Email is invalid",
          subject: "Subject can't be blank",
          message: "Message is too short (minimum is 10 characters)"
        }
      )
    end

    it "redirects with captcha errors when verification fails" do
      allow(TurnstileVerifier).to receive(:verify).and_return(false)

      expect {
        post contacts_path, params: {
          name: "Jane Doe",
          email: "jane@example.com",
          subject: "Hello",
          message: "I want to work with you on a project.",
          "cf-turnstile-response" => "invalid-token"
        }
      }.not_to change(Contact, :count)

      expect(response).to redirect_to(root_path(anchor: "contact"))
      follow_redirect!
      expect(inertia).to have_props(
        errors: { captcha: I18n.t("contact.captcha_failed") }
      )
    end

    it "silently accepts honeypot spam" do
      expect {
        post contacts_path, params: {
          name: "Bot",
          email: "bot@example.com",
          subject: "Spam",
          message: "Buy my product please now.",
          website: "http://spam.test",
          "cf-turnstile-response" => "valid-token"
        }
      }.not_to change(Contact, :count)

      expect(response).to redirect_to(root_path(anchor: "contact"))
    end

    it "redirects with alert when rate limited" do
      contact_params = {
        name: "Jane Doe",
        email: "jane@example.com",
        subject: "Hello",
        message: "I want to work with you on a project.",
        "cf-turnstile-response" => "valid-token"
      }

      ContactRateLimit.reset!

      5.times do
        post contacts_path, params: contact_params
      end

      post contacts_path,
           params: contact_params.merge(
             email: "other@example.com",
             subject: "Hello again",
             message: "Another message for you."
           )

      expect(response).to have_http_status(:redirect)
      expect(response.body).not_to include("Retry later")
      follow_redirect!
      expect(inertia).to have_flash(alert: I18n.t("contact.rate_limited"))
    end
  end
end
