# frozen_string_literal: true

FactoryBot.define do
  factory :skill do
    profile
    sequence(:name) { |n| "Skill #{n}" }
    sequence(:slug) { |n| "skill-#{n}" }
    category { "backend" }
    sequence(:icon) { |n| "icon-#{n}" }
    description { "Technology used professionally" }
    level { "advanced" }
    position { 0 }
  end
end
