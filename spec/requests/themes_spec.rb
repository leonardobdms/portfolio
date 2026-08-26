# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Themes", type: :request do
  describe "GET /theme" do
    it "stores a supported theme and redirects back" do
      get switch_theme_path, params: { theme: "light" }, headers: { "HTTP_REFERER" => root_url }

      expect(response).to redirect_to(root_url)
      expect(cookies[:theme]).to eq("light")
    end

    it "ignores an unsupported theme" do
      get switch_theme_path, params: { theme: "neon" }, headers: { "HTTP_REFERER" => root_url }

      expect(response).to redirect_to(root_url)
      expect(cookies[:theme]).to be_blank
    end

    it "shares the current theme with Inertia pages" do
      cookies[:theme] = "light"

      get root_path

      expect(inertia).to have_props(theme: "light")
    end
  end
end
