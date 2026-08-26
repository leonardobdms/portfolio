# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Home", type: :request do
  describe "GET /" do
    it "renders the home page with profile props" do
      profile = create(:profile)

      get root_path

      expect(response).to have_http_status(:ok)
      expect(inertia).to render_component("home/index")
      expect(inertia).to have_props(locale: "en", theme: "dark")
      expect(inertia.props[:profile][:name]).to eq(profile.name)
    end

    it "includes data for every home section" do
      create_complete_profile

      get root_path

      profile_props = inertia.props[:profile]
      expect(profile_props[:skills].size).to eq(2)
      expect(profile_props[:experiences].size).to eq(1)
      expect(profile_props[:projects].size).to eq(2)
      expect(profile_props[:certifications].size).to eq(1)
      expect(profile_props[:educations].size).to eq(1)
      expect(profile_props[:social_links].size).to eq(1)
      expect(profile_props[:bio]).to be_present
      expect(profile_props[:email]).to be_present
    end

    it "embeds Person JSON-LD for the current profile" do
      create_complete_profile

      get root_path

      body = CGI.unescapeHTML(response.body)
      expect(body).to include("application/ld+json")
      expect(body).to include('"@type":"Person"')
      expect(body).to include("Example University")
    end

    it "shares the Turnstile site key when configured" do
      create(:profile)
      allow(ENV).to receive(:[]).and_call_original
      allow(ENV).to receive(:[]).with("TURNSTILE_SITE_KEY").and_return("site-key")

      get root_path

      expect(inertia).to have_props(turnstile_site_key: "site-key")
    end
  end
end
