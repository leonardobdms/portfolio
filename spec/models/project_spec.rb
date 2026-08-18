# frozen_string_literal: true

require "rails_helper"

RSpec.describe Project, type: :model do
  it "creates a valid project" do
    expect(create(:project)).to be_persisted
  end

  it "belongs to a profile" do
    expect(described_class.reflect_on_association(:profile).macro).to eq(:belongs_to)
  end

  it "has many skills through project_skills" do
    project_skills = described_class.reflect_on_association(:project_skills)
    skills = described_class.reflect_on_association(:skills)

    expect(project_skills.macro).to eq(:has_many)
    expect(skills.macro).to eq(:has_many)
    expect(skills.options[:through]).to eq(:project_skills)
  end

  %i[name slug].each do |attribute|
    it "is invalid without #{attribute}" do
      project = build(:project, attribute => nil)

      expect(project).not_to be_valid
      expect(project.errors[attribute]).to be_present
    end
  end

  it "validates uniqueness of slug" do
    create(:project, slug: "portfolio")
    duplicate = build(:project, slug: "portfolio")

    expect(duplicate).not_to be_valid
    expect(duplicate.errors[:slug]).to be_present
  end

  it "enforces slug uniqueness at the database level" do
    create(:project, slug: "api")
    duplicate = build(:project, slug: "api")

    expect { duplicate.save!(validate: false) }.to raise_error(ActiveRecord::RecordNotUnique)
  end

  it "associates many skills" do
    project = create(:project)
    ruby = create(:skill, profile: project.profile, slug: "ruby", icon: "ruby")
    rails = create(:skill, profile: project.profile, slug: "rails", icon: "rails")

    project.skills << [ ruby, rails ]

    expect(project.reload.skills).to contain_exactly(ruby, rails)
  end

  it "destroys join records when the project is destroyed" do
    project = create(:project)
    skill = create(:skill, profile: project.profile)
    create(:project_skill, project: project, skill: skill)

    expect { project.destroy }.to change(ProjectSkill, :count).by(-1)
    expect(skill.reload).to be_persisted
  end
end
