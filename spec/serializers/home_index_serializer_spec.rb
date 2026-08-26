# frozen_string_literal: true

require "rails_helper"

RSpec.describe HomeIndexSerializer do
  it "serializes the current profile" do
    profile = create(:profile, name: "Ada Lovelace")
    page = Struct.new(:profile).new(profile)

    json = serialize_json(page)

    expect(json.fetch("profile").fetch("name")).to eq("Ada Lovelace")
  end
end
