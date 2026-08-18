# frozen_string_literal: true

require "rails_helper"

RSpec.describe ExperienceSerializer do
  it "serializes experience attributes without a nested profile" do
    experience = create(:experience, current: false)
    json = serialize_json(experience)

    expect(json.fetch("id")).to eq(experience.id)
    expect(json.fetch("profile_id")).to eq(experience.profile_id)
    expect(json.fetch("company")).to eq(experience.company)
    expect(json.fetch("role")).to eq(experience.role)
    expect(json.fetch("employment_type")).to eq(experience.employment_type)
    expect(json.fetch("start_date")).to eq("2022-01-01")
    expect(json.fetch("end_date")).to eq("2023-01-01")
    expect(json.fetch("current")).to be(false)
    expect(json).not_to have_key("profile")
  end

  it "serializes a current experience with a null end date" do
    experience = create(:experience, current: true, end_date: nil)
    json = serialize_json(experience)

    expect(json.fetch("current")).to be(true)
    expect(json.fetch("end_date")).to be_nil
  end
end
