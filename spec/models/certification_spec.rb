# frozen_string_literal: true

require "rails_helper"

RSpec.describe Certification, type: :model do
  it "creates a valid certification" do
    expect(create(:certification)).to be_persisted
  end

  it "belongs to a profile" do
    expect(described_class.reflect_on_association(:profile).macro).to eq(:belongs_to)
  end

  %i[name issuer].each do |attribute|
    it "is invalid without #{attribute}" do
      certification = build(:certification, attribute => nil)

      expect(certification).not_to be_valid
      expect(certification.errors[attribute]).to be_present
    end
  end

  it "allows optional credential details and expiration" do
    certification = build(
      :certification,
      description: nil,
      credential_url: nil,
      credential_id: nil,
      issued_at: nil,
      expires_at: nil
    )

    expect(certification).to be_valid
  end
end
