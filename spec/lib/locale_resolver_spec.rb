# frozen_string_literal: true

require "rails_helper"

RSpec.describe LocaleResolver do
  it "prefers a supported cookie locale" do
    expect(described_class.call(cookies: { locale: "pt-BR" })).to eq("pt-BR")
  end

  it "ignores an unsupported cookie locale" do
    expect(described_class.call(cookies: { locale: "fr" }, accept_language: "en")).to eq("en")
  end

  it "detects Portuguese from Accept-Language" do
    expect(described_class.call(cookies: {}, accept_language: "pt,en;q=0.8")).to eq("pt-BR")
  end

  it "detects English from Accept-Language" do
    expect(described_class.call(cookies: {}, accept_language: "en-US,en;q=0.9")).to eq("en")
  end

  it "falls back to the default locale" do
    expect(described_class.call(cookies: {}, accept_language: "de,fr;q=0.8")).to eq("en")
  end
end
