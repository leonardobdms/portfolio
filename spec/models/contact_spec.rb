# frozen_string_literal: true

require "rails_helper"

RSpec.describe Contact, type: :model do
  it "is valid with expected attributes" do
    expect(build(:contact)).to be_valid
  end

  %i[name email subject message].each do |attribute|
    it "is invalid without #{attribute}" do
      message = build(:contact, attribute => nil)

      expect(message).not_to be_valid
      expect(message.errors[attribute]).to be_present
    end
  end

  it "rejects invalid email addresses" do
    message = build(:contact, email: "not-an-email")

    expect(message).not_to be_valid
    expect(message.errors[:email]).to be_present
  end

  it "requires a minimum message length" do
    message = build(:contact, message: "too short")

    expect(message).not_to be_valid
    expect(message.errors[:message]).to be_present
  end
end
