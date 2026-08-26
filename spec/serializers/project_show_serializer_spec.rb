# frozen_string_literal: true

require "rails_helper"

RSpec.describe ProjectShowSerializer do
  it "serializes navigation slugs" do
    profile = create(:profile)
    project = create(:project, profile:)
    page = Struct.new(:profile, :project, :previous_slug, :next_slug, keyword_init: true)
      .new(profile:, project:, previous_slug: "prev", next_slug: nil)

    json = serialize_json(page, ProjectShowSerializer)

    expect(json.fetch("previous_slug")).to eq("prev")
    expect(json.fetch("next_slug")).to be_nil
    expect(json.fetch("project").fetch("slug")).to eq(project.slug)
  end
end
