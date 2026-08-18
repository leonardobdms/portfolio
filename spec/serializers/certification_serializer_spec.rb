# frozen_string_literal: true

require "rails_helper"

RSpec.describe CertificationSerializer do
  it "serializes certification attributes without a nested profile" do
    certification = create(:certification, issued_at: Date.new(2024, 6, 1), expires_at: Date.new(2026, 6, 1))
    json = serialize_json(certification)

    expect(json.fetch("id")).to eq(certification.id)
    expect(json.fetch("profile_id")).to eq(certification.profile_id)
    expect(json.fetch("name")).to eq(certification.name)
    expect(json.fetch("issuer")).to eq(certification.issuer)
    expect(json.fetch("credential_url")).to eq(certification.credential_url)
    expect(json.fetch("credential_id")).to eq(certification.credential_id)
    expect(json.fetch("issued_at")).to eq("2024-06-01")
    expect(json.fetch("expires_at")).to eq("2026-06-01")
    expect(json).not_to have_key("profile")
  end

  it "serializes optional dates as null when empty" do
    certification = create(:certification, issued_at: nil, expires_at: nil)
    json = serialize_json(certification)

    expect(json.fetch("issued_at")).to be_nil
    expect(json.fetch("expires_at")).to be_nil
  end
end
