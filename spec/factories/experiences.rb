# frozen_string_literal: true

FactoryBot.define do
  factory :experience do
    profile
    company { "Acme" }
    role { "Software Engineer" }
    employment_type { "CLT" }
    location { "Remote" }
    description { "Worked on backend systems" }
    start_date { Date.new(2022, 1, 1) }
    end_date { Date.new(2023, 1, 1) }
    current { false }
    position { 0 }
  end
end
