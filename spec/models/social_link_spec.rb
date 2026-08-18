# frozen_string_literal: true

require "rails_helper"

RSpec.describe SocialLink, type: :model do
  it "creates a valid social link" do
    expect(create(:social_link)).to be_persisted
  end

  it "belongs to a profile" do
    expect(described_class.reflect_on_association(:profile).macro).to eq(:belongs_to)
  end

  %i[platform url].each do |attribute|
    it "is invalid without #{attribute}" do
      social_link = build(:social_link, attribute => nil)

      expect(social_link).not_to be_valid
      expect(social_link.errors[attribute]).to be_present
    end
  end

  it "does not restrict platform to a fixed list" do
    expect(build(:social_link, platform: "Mastodon", url: "https://mastodon.social/@example")).to be_valid
  end

  it "allows optional username and icon" do
    expect(build(:social_link, username: nil, icon: nil)).to be_valid
  end
end
