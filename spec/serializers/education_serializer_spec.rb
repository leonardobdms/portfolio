# frozen_string_literal: true

require "rails_helper"

RSpec.describe EducationSerializer do
  it "serializes education attributes without a nested profile" do
    education = create(:education)
    json = serialize_json(education)

    expect(json.fetch("id")).to eq(education.id)
    expect(json.fetch("profile_id")).to eq(education.profile_id)
    expect(json.fetch("institution")).to eq(education.institution)
    expect(json.fetch("course")).to eq(education.course)
    expect(json.fetch("degree")).to eq(education.degree)
    expect(json.fetch("start_date")).to eq("2018-02-01")
    expect(json).not_to have_key("profile")
  end

  it "serializes optional fields as null when empty" do
    education = create(:education, degree: nil, description: nil, end_date: nil)
    json = serialize_json(education)

    expect(json.fetch("degree")).to be_nil
    expect(json.fetch("description")).to be_nil
    expect(json.fetch("end_date")).to be_nil
  end
end
