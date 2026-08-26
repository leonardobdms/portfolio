# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Sitemaps", type: :request do
  describe "GET /sitemap.xml" do
    it "lists the home page and projects" do
      profile = create(:profile)
      project = create(:project, profile:)

      get sitemap_path(format: :xml)

      expect(response).to have_http_status(:ok)
      expect(response.body).to include(root_url)
      expect(response.body).to include(project_url(project))
    end

    it "lists only the home page when there is no profile" do
      get sitemap_path(format: :xml)

      expect(response).to have_http_status(:ok)
      expect(response.body).to include(root_url)
      expect(response.body).not_to include("/projects/")
    end
  end
end
