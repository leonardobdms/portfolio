# frozen_string_literal: true

FactoryBot.define do
  factory :profile do
    name { "Test User" }
    headline { "Backend Developer" }
    bio { "Professional description" }
    location { "Brazil" }
    sequence(:email) { |n| "profile#{n}@example.com" }
    available_for_work { false }
  end
end
