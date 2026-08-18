# frozen_string_literal: true

FactoryBot.define do
  factory :certification do
    profile
    name { "Example Certification" }
    issuer { "Example Issuer" }
    description { "Professional certification" }
    credential_url { "https://example.com/credential" }
    credential_id { "ABC-123" }
    issued_at { Date.new(2024, 6, 1) }
    position { 0 }
  end
end
