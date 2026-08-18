# frozen_string_literal: true

require "rails_helper"

RSpec.describe ProjectSkillSerializer do
  it "serializes the join record and nested skill without a nested project" do
    project_skill = create(:project_skill)
    json = serialize_json(project_skill)

    expect(json.fetch("id")).to eq(project_skill.id)
    expect(json.fetch("project_id")).to eq(project_skill.project_id)
    expect(json.fetch("skill_id")).to eq(project_skill.skill_id)
    expect(json.fetch("skill").fetch("id")).to eq(project_skill.skill_id)
    expect(json.fetch("skill").fetch("icon")).to eq(project_skill.skill.icon)
    expect(json).not_to have_key("project")
    expect(json.fetch("skill")).not_to have_key("projects")
  end
end
