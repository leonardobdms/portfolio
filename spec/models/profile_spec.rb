# frozen_string_literal: true

require "rails_helper"

RSpec.describe Profile, type: :model do
  it "creates a valid profile" do
    expect(create(:profile)).to be_persisted
  end

  it "is invalid without a name" do
    profile = build(:profile, name: nil)

    expect(profile).not_to be_valid
    expect(profile.errors[:name]).to be_present
  end

  it "belongs to no parent and has the expected associations" do
    expect(described_class.reflect_on_association(:experiences).macro).to eq(:has_many)
    expect(described_class.reflect_on_association(:educations).macro).to eq(:has_many)
    expect(described_class.reflect_on_association(:skills).macro).to eq(:has_many)
    expect(described_class.reflect_on_association(:projects).macro).to eq(:has_many)
    expect(described_class.reflect_on_association(:certifications).macro).to eq(:has_many)
    expect(described_class.reflect_on_association(:social_links).macro).to eq(:has_many)
  end

  it "destroys dependent records" do
    profile = create(:profile)
    create(:experience, profile: profile)
    create(:education, profile: profile)
    create(:skill, profile: profile)
    create(:project, profile: profile)
    create(:certification, profile: profile)
    create(:social_link, profile: profile)

    expect { profile.destroy }.to change(Experience, :count).by(-1)
      .and change(Education, :count).by(-1)
      .and change(Skill, :count).by(-1)
      .and change(Project, :count).by(-1)
      .and change(Certification, :count).by(-1)
      .and change(SocialLink, :count).by(-1)
  end

  it "orders associations by position" do
    profile = create(:profile)
    second = create(:experience, profile: profile, position: 2, company: "Second")
    first = create(:experience, profile: profile, position: 1, company: "First")

    expect(profile.experiences).to eq([ first, second ])
  end

  describe ".current" do
    it "returns the first profile" do
      first = create(:profile, name: "First")
      create(:profile, name: "Second")

      expect(described_class.current).to eq(first)
    end

    it "returns nil when no profile exists" do
      expect(described_class.current).to be_nil
    end
  end
end
