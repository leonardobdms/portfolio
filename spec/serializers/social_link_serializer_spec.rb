# frozen_string_literal: true

require "rails_helper"

RSpec.describe SocialLinkSerializer do
  it "serializes social link attributes without a nested profile" do
    social_link = create(:social_link, platform: "LinkedIn", url: "https://linkedin.com/in/example")
    json = serialize_json(social_link)

    expect(json.fetch("id")).to eq(social_link.id)
    expect(json.fetch("profile_id")).to eq(social_link.profile_id)
    expect(json.fetch("platform")).to eq("LinkedIn")
    expect(json.fetch("url")).to eq("https://linkedin.com/in/example")
    expect(json.fetch("username")).to eq(social_link.username)
    expect(json.fetch("icon")).to eq(social_link.icon)
    expect(json).not_to have_key("profile")
  end

  it "serializes optional username and icon as null when empty" do
    social_link = create(:social_link, username: nil, icon: nil)
    json = serialize_json(social_link)

    expect(json.fetch("username")).to be_nil
    expect(json.fetch("icon")).to be_nil
  end
end
