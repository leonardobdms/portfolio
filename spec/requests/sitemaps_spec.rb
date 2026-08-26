# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Sitemaps", type: :request do
  let!(:profile) { create(:profile) }
  let!(:project) { create(:project, profile:) }

  describe "GET /sitemap.xml" do
    it "lists the home page and projects" do
      get sitemap_path(format: :xml)

      expect(response).to have_http_status(:ok)
      expect(response.body).to include(root_url)
      expect(response.body).to include(project_url(project))
    end
  end
end
