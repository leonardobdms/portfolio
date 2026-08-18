# frozen_string_literal: true

require "rails_helper"

RSpec.describe ProfileSerializer do
  let(:profile) { create(:profile, available_for_work: true) }

  it "serializes profile attributes" do
    json = serialize_json(profile)

    expect(json.fetch("id")).to eq(profile.id)
    expect(json.fetch("name")).to eq(profile.name)
    expect(json.fetch("headline")).to eq(profile.headline)
    expect(json.fetch("bio")).to eq(profile.bio)
    expect(json.fetch("location")).to eq(profile.location)
    expect(json.fetch("email")).to eq(profile.email)
    expect(json.fetch("available_for_work")).to be(true)
  end

  it "serializes empty associations as empty arrays" do
    json = serialize_json(profile)

    %w[experiences educations skills projects certifications social_links].each do |key|
      expect(json.fetch(key)).to eq([])
    end
  end

  it "serializes nested associations without nesting profile back" do
    create(:experience, profile: profile)
    create(:education, profile: profile)
    skill = create(:skill, profile: profile, name: "Ruby", slug: "ruby", icon: "ruby")
    project = create(:project, profile: profile)
    create(:project_skill, project: project, skill: skill)
    create(:certification, profile: profile)
    create(:social_link, profile: profile)

    json = serialize_json(profile.reload)

    expect(json.fetch("experiences").size).to eq(1)
    expect(json.fetch("educations").size).to eq(1)
    expect(json.fetch("skills").size).to eq(1)
    expect(json.fetch("projects").size).to eq(1)
    expect(json.fetch("certifications").size).to eq(1)
    expect(json.fetch("social_links").size).to eq(1)

    json.fetch("projects").first.fetch("skills").tap do |skills|
      expect(skills.first.fetch("icon")).to eq("ruby")
      expect(skills.first).not_to have_key("profile")
      expect(skills.first).not_to have_key("projects")
    end

    %w[experiences educations skills projects certifications social_links].each do |key|
      json.fetch(key).each do |item|
        expect(item).not_to have_key("profile")
      end
    end
  end

  it "does not include a nested profile object on itself" do
    json = serialize_json(profile)

    expect(json.keys).not_to include("profile")
  end
end
