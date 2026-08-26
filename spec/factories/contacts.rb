# frozen_string_literal: true

FactoryBot.define do
  factory :contact do
    name { "Jane Doe" }
    sequence(:email) { |n| "jane#{n}@gmail.com" }
    subject { "Project inquiry" }
    message { "I would like to discuss a project with you." }
    ip { "127.0.0.1" }
    user_agent { "RSpec" }
  end
end
