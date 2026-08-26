# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Projects", type: :request do
  let!(:profile) { create(:profile) }

  describe "GET /projects/:slug" do
    it "renders the project page" do
      project = create(:project, profile:)

      get project_path(project.slug)

      expect(response).to have_http_status(:ok)
      expect(inertia).to render_component("projects/show")
      expect(inertia.props[:project][:slug]).to eq(project.slug)
      expect(inertia.props[:profile][:name]).to eq(profile.name)
    end

    it "includes navigation slugs in props" do
      first_project = create(:project, profile:, position: 1, slug: "first")
      second_project = create(:project, profile:, position: 2, slug: "second")

      get project_path(second_project.slug)

      expect(inertia.props[:previous_slug]).to eq("first")
      expect(inertia.props[:next_slug]).to be_nil
    end

    it "returns not found for unknown slugs" do
      get project_path("missing-project")

      expect(response).to have_http_status(:not_found)
    end
  end
end
