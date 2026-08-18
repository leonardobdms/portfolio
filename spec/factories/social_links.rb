# frozen_string_literal: true

FactoryBot.define do
  factory :social_link do
    profile
    platform { "GitHub" }
    url { "https://github.com/example" }
    username { "example" }
    icon { "github" }
    position { 0 }
  end
end
