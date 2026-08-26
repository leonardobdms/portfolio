# frozen_string_literal: true

require "rails_helper"

RSpec.describe ContactRateLimit do
  around do |example|
    described_class.reset!
    example.run
    described_class.reset!
  end

  it "increments a counter per IP" do
    expect(described_class.increment("1.1.1.1")).to eq(1)
    expect(described_class.increment("1.1.1.1")).to eq(2)
    expect(described_class.increment("2.2.2.2")).to eq(1)
  end

  it "uses Rails.cache outside the test environment" do
    allow(Rails.env).to receive(:test?).and_return(false)

    expect(described_class.cache).to eq(Rails.cache)
  end
end
