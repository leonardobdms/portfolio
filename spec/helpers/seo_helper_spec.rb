# frozen_string_literal: true

require "rails_helper"

RSpec.describe SeoHelper, type: :helper do
  describe "#person_json_ld" do
    it "builds Person structured data from profile associations" do
      profile = create_complete_profile

      json = helper.person_json_ld(profile)

      expect(json["@type"]).to eq("Person")
      expect(json["name"]).to eq(profile.name)
      expect(json["jobTitle"]).to eq(profile.headline)
      expect(json["email"]).to eq(profile.email)
      expect(json["address"]).to eq(profile.location)
      expect(json["sameAs"]).to include(
        "https://github.com/example",
        "https://linkedin.com/in/example",
        "https://example.com"
      )
      expect(json["knowsAbout"]).to include("Ruby", "Vue")
      expect(json["alumniOf"]).to eq([ "Example University" ])
    end

    it "omits blank fields and uses profile URLs when there are no social links" do
      profile = create(
        :profile,
        headline: nil,
        email: nil,
        location: nil,
        github_url: "https://github.com/solo",
        linkedin_url: nil,
        website_url: nil
      )

      json = helper.person_json_ld(profile)

      expect(json).not_to have_key("jobTitle")
      expect(json).not_to have_key("email")
      expect(json).not_to have_key("address")
      expect(json["sameAs"]).to eq([ "https://github.com/solo" ])
      expect(json["knowsAbout"]).to eq([])
      expect(json["alumniOf"]).to eq([])
    end
  end
end
