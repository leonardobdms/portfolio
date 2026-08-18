# frozen_string_literal: true

require "rails_helper"

RSpec.describe ProjectSerializer do
  it "serializes project attributes without a nested profile" do
    project = create(:project, featured: true, slug: "portfolio")
    json = serialize_json(project)

    expect(json.fetch("id")).to eq(project.id)
    expect(json.fetch("profile_id")).to eq(project.profile_id)
    expect(json.fetch("name")).to eq(project.name)
    expect(json.fetch("slug")).to eq("portfolio")
    expect(json.fetch("featured")).to be(true)
    expect(json.fetch("skills")).to eq([])
    expect(json).not_to have_key("profile")
    expect(json).not_to have_key("project_skills")
  end

  it "serializes associated skills without nesting projects" do
    project = create(:project)
    skill = create(:skill, profile: project.profile, name: "PostgreSQL", slug: "postgresql", icon: "postgresql")
    project.skills << skill

    json = serialize_json(project.reload)
    serialized_skill = json.fetch("skills").first

    expect(serialized_skill.fetch("name")).to eq("PostgreSQL")
    expect(serialized_skill.fetch("icon")).to eq("postgresql")
    expect(serialized_skill).not_to have_key("projects")
    expect(serialized_skill).not_to have_key("profile")
  end
end
