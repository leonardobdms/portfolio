# frozen_string_literal: true

require "rails_helper"

RSpec.describe Skill, type: :model do
  it "creates a valid skill with an icon identifier" do
    skill = create(:skill, name: "Ruby on Rails", slug: "ruby-on-rails", icon: "rails")

    expect(skill).to be_persisted
    expect(skill.icon).to eq("rails")
  end

  it "belongs to a profile" do
    expect(described_class.reflect_on_association(:profile).macro).to eq(:belongs_to)
  end

  it "has many projects through project_skills" do
    project_skills = described_class.reflect_on_association(:project_skills)
    projects = described_class.reflect_on_association(:projects)

    expect(project_skills.macro).to eq(:has_many)
    expect(projects.macro).to eq(:has_many)
    expect(projects.options[:through]).to eq(:project_skills)
  end

  %i[name slug category icon].each do |attribute|
    it "is invalid without #{attribute}" do
      skill = build(:skill, attribute => nil)

      expect(skill).not_to be_valid
      expect(skill.errors[attribute]).to be_present
    end
  end

  it "validates uniqueness of slug" do
    create(:skill, slug: "ruby")
    duplicate = build(:skill, slug: "ruby")

    expect(duplicate).not_to be_valid
    expect(duplicate.errors[:slug]).to be_present
  end

  it "enforces slug uniqueness at the database level" do
    create(:skill, slug: "postgresql")
    duplicate = build(:skill, slug: "postgresql")

    expect { duplicate.save!(validate: false) }.to raise_error(ActiveRecord::RecordNotUnique)
  end

  it "accepts simple technology icon identifiers" do
    %w[ruby rails vue javascript postgresql docker git github gitlab rspec openai].each do |icon|
      expect(build(:skill, icon: icon)).to be_valid
    end
  end

  it "rejects file-like or URL icon values" do
    %w[rails.png rails.svg https://cdn.example.com/rails.svg /icons/rails.png].each do |icon|
      skill = build(:skill, icon: icon)

      expect(skill).not_to be_valid
      expect(skill.errors[:icon]).to be_present
    end
  end

  it "allows optional description and level" do
    expect(build(:skill, description: nil, level: nil)).to be_valid
  end

  it "exposes associated projects through the join model" do
    skill = create(:skill)
    project = create(:project, profile: skill.profile)

    skill.projects << project

    expect(skill.reload.projects).to contain_exactly(project)
  end

  it "destroys join records when the skill is destroyed" do
    skill = create(:skill)
    project = create(:project, profile: skill.profile)
    create(:project_skill, project: project, skill: skill)

    expect { skill.destroy }.to change(ProjectSkill, :count).by(-1)
    expect(project.reload).to be_persisted
  end
end
