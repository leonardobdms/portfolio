# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Home", type: :request do
  let!(:profile) { create(:profile) }

  describe "GET /" do
    it "renders the home page with profile props" do
      get root_path

      expect(response).to have_http_status(:ok)
      expect(inertia).to render_component("home/index")
      expect(inertia.props[:profile][:name]).to eq(profile.name)
      expect(inertia).to have_props(locale: "en", theme: "dark")
    end
  end
end
