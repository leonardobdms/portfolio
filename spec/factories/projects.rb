# frozen_string_literal: true

FactoryBot.define do
  factory :project do
    profile
    sequence(:name) { |n| "Project #{n}" }
    sequence(:slug) { |n| "project-#{n}" }
    short_description { "A short project summary" }
    description { "A longer project description" }
    featured { false }
    position { 0 }
    start_date { Date.new(2024, 1, 1) }
  end
end
