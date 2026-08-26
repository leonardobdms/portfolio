# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Skill icon registry" do
  SEEDED_SKILL_ICONS = [
    "ruby", "ruby-on-rails", "php", "rest-apis", "sql", "postgresql", "redis", "sidekiq",
    "vue-js", "nuxt-js", "javascript", "typescript", "html5", "css3", "tailwind-css", "bootstrap",
    "rspec", "rswag", "openapi", "swagger", "openai-api", "apis-de-terceiros", "webhooks",
    "pagbank", "paypal", "integracoes-fiscais", "nasajon", "nfe-io", "assinaturas-recorrentes",
    "wordpress", "docker", "docker-compose", "linux", "git", "github", "gitlab",
    "mvc", "clean-code", "i18n"
  ].freeze

  it "maps every seeded skill icon slug" do
    registry_source = Rails.root.join("app/frontend/lib/skill-icons.ts").read

    missing = SEEDED_SKILL_ICONS.reject do |icon|
      registry_source.match?(/["']?#{Regexp.escape(icon)}["']?:/)
    end

    expect(missing).to eq([])
  end
end
