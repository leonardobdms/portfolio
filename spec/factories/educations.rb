# frozen_string_literal: true

FactoryBot.define do
  factory :education do
    profile
    institution { "Example University" }
    course { "Computer Science" }
    degree { "Bachelor" }
    description { "Undergraduate studies" }
    start_date { Date.new(2018, 2, 1) }
    end_date { Date.new(2022, 12, 1) }
    current { false }
    position { 0 }
  end
end
