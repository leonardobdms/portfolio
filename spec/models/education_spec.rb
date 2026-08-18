# frozen_string_literal: true

require "rails_helper"

RSpec.describe Education, type: :model do
  it "creates a valid education" do
    expect(create(:education)).to be_persisted
  end

  it "belongs to a profile" do
    expect(described_class.reflect_on_association(:profile).macro).to eq(:belongs_to)
  end

  it "is invalid without a profile" do
    expect(build(:education, profile: nil)).not_to be_valid
  end

  %i[institution course start_date].each do |attribute|
    it "is invalid without #{attribute}" do
      education = build(:education, attribute => nil)

      expect(education).not_to be_valid
      expect(education.errors[attribute]).to be_present
    end
  end

  it "allows optional degree, description and end date" do
    education = build(:education, degree: nil, description: nil, end_date: nil, current: true)

    expect(education).to be_valid
  end
end
