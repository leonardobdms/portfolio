# frozen_string_literal: true

require "rails_helper"

RSpec.describe Experience, type: :model do
  it "creates a valid experience" do
    expect(create(:experience)).to be_persisted
  end

  it "belongs to a profile" do
    association = described_class.reflect_on_association(:profile)

    expect(association.macro).to eq(:belongs_to)
  end

  it "is invalid without a profile" do
    expect(build(:experience, profile: nil)).not_to be_valid
  end

  %i[company role start_date].each do |attribute|
    it "is invalid without #{attribute}" do
      experience = build(:experience, attribute => nil)

      expect(experience).not_to be_valid
      expect(experience.errors[attribute]).to be_present
    end
  end

  it "allows optional employment details and an open end date" do
    experience = build(:experience, employment_type: nil, location: nil, description: nil, end_date: nil, current: true)

    expect(experience).to be_valid
  end
end
