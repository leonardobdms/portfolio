# frozen_string_literal: true

require "rails_helper"

RSpec.describe SkillSerializer do
  it "serializes skill attributes including the icon identifier" do
    skill = create(
      :skill,
      name: "Ruby on Rails",
      slug: "ruby-on-rails",
      category: "backend",
      icon: "rails",
      description: "Web framework",
      level: "advanced",
      position: 1
    )
    json = serialize_json(skill)

    expect(json.fetch("name")).to eq("Ruby on Rails")
    expect(json.fetch("slug")).to eq("ruby-on-rails")
    expect(json.fetch("category")).to eq("backend")
    expect(json.fetch("icon")).to eq("rails")
    expect(json.fetch("description")).to eq("Web framework")
    expect(json.fetch("level")).to eq("advanced")
    expect(json.fetch("position")).to eq(1)
    expect(json.fetch("icon")).to be_a(String)
  end

  it "does not serialize image files or nested associations that would recurse" do
    skill = create(:skill, icon: "vue")
    json = serialize_json(skill)

    expect(json.keys).not_to include("profile", "projects", "project_skills", "image", "image_url", "svg", "file")
    expect(json.fetch("icon")).not_to include("<svg", "data:image", ".png", ".svg")
  end

  it "serializes optional fields as null when empty" do
    skill = create(:skill, description: nil, level: nil)
    json = serialize_json(skill)

    expect(json.fetch("description")).to be_nil
    expect(json.fetch("level")).to be_nil
  end
end
