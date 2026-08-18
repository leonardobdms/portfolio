# frozen_string_literal: true

require "rails_helper"

RSpec.describe ProjectSkill, type: :model do
  it "creates a valid project-skill association" do
    expect(create(:project_skill)).to be_persisted
  end

  it "belongs to a project and a skill" do
    expect(described_class.reflect_on_association(:project).macro).to eq(:belongs_to)
    expect(described_class.reflect_on_association(:skill).macro).to eq(:belongs_to)
  end

  it "is invalid without a project" do
    skill = create(:skill)

    expect(build(:project_skill, project: nil, skill: skill)).not_to be_valid
  end

  it "is invalid without a skill" do
    expect(build(:project_skill, skill: nil)).not_to be_valid
  end

  it "does not allow the same skill twice on a project" do
    project_skill = create(:project_skill)
    duplicate = build(:project_skill, project: project_skill.project, skill: project_skill.skill)

    expect(duplicate).not_to be_valid
    expect(duplicate.errors[:skill_id]).to be_present
  end

  it "enforces uniqueness of project and skill at the database level" do
    project_skill = create(:project_skill)
    duplicate = described_class.new(project: project_skill.project, skill: project_skill.skill)

    expect { duplicate.save!(validate: false) }.to raise_error(ActiveRecord::RecordNotUnique)
  end

  it "allows the same skill on different projects" do
    skill = create(:skill)
    first_project = create(:project, profile: skill.profile)
    second_project = create(:project, profile: skill.profile)

    create(:project_skill, project: first_project, skill: skill)

    expect(build(:project_skill, project: second_project, skill: skill)).to be_valid
  end
end
