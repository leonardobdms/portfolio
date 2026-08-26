# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Locales", type: :request do
  describe "GET /locale" do
    it "stores a supported locale and redirects back" do
      get switch_locale_path, params: { locale: "pt-BR" }, headers: { "HTTP_REFERER" => root_url }

      expect(response).to redirect_to(root_url)
      expect(cookies[:locale]).to eq("pt-BR")
    end

    it "ignores an unsupported locale" do
      get switch_locale_path, params: { locale: "fr" }, headers: { "HTTP_REFERER" => root_url }

      expect(response).to redirect_to(root_url)
      expect(cookies[:locale]).to be_blank
    end
  end

  describe "locale resolution" do
    it "shares the current locale with Inertia pages" do
      get new_admin_session_path

      expect(inertia).to have_props(locale: "en")
    end

    it "uses the cookie locale on the next request" do
      cookies[:locale] = "pt-BR"

      get new_admin_session_path

      expect(inertia).to have_props(locale: "pt-BR")
    end

    it "detects Portuguese from the Accept-Language header" do
      get new_admin_session_path, headers: { "HTTP_ACCEPT_LANGUAGE" => "pt-BR,pt;q=0.9" }

      expect(inertia).to have_props(locale: "pt-BR")
    end

    it "translates Devise alerts to Portuguese" do
      cookies[:locale] = "pt-BR"

      post admin_session_path, params: {
        admin: { email: "nobody@example.com", password: "wrong-password" }
      }

      expect(inertia).to have_flash(
        alert: "E-mail ou senha inválidos."
      )
    end

    it "falls back to English when Accept-Language is unsupported" do
      get new_admin_session_path, headers: { "HTTP_ACCEPT_LANGUAGE" => "fr-FR,fr;q=0.9" }

      expect(inertia).to have_props(locale: "en")
    end

    it "redirects to the home page when there is no referer" do
      get switch_locale_path, params: { locale: "pt-BR" }

      expect(response).to redirect_to(root_path)
      expect(cookies[:locale]).to eq("pt-BR")
    end
  end
end
