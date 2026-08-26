# frozen_string_literal: true

require "rails_helper"

RSpec.describe ThemeResolver do
  it "returns a supported cookie theme" do
    expect(described_class.call(cookies: { theme: "light" })).to eq("light")
  end

  it "falls back to dark for an unsupported theme" do
    expect(described_class.call(cookies: { theme: "neon" })).to eq("dark")
  end

  it "falls back to dark when no cookie is present" do
    expect(described_class.call(cookies: {})).to eq("dark")
  end

  it "maps supported themes to an html class" do
    expect(described_class.html_class("light")).to eq("light")
    expect(described_class.html_class("dark")).to eq("dark")
  end

  it "maps unsupported themes to the default html class" do
    expect(described_class.html_class("neon")).to eq("dark")
  end
end
