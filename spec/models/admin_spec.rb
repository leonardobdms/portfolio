# frozen_string_literal: true

require "rails_helper"

RSpec.describe Admin, type: :model do
  it "is valid with email and password" do
    expect(build(:admin)).to be_valid
  end

  it "is invalid without an email" do
    expect(build(:admin, email: nil)).not_to be_valid
  end
end
