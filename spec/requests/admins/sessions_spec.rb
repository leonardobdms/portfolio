# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Admin sessions", type: :request do
  describe "GET /admins/sign_in" do
    it "renders the Inertia login page instead of Devise views" do
      get new_admin_session_path

      expect(response).to have_http_status(:ok)
      expect(inertia).to render_component("admins/sessions/new")
      expect(inertia).to have_props(
        email: nil,
        session_url: admin_session_path,
        locale: "en"
      )
    end
  end

  describe "POST /admins/sign_in" do
    it "signs the admin in and redirects to Avo" do
      admin = create(:admin)

      post admin_session_path, params: {
        admin: { email: admin.email, password: "password123" }
      }

      expect(response).to redirect_to("/admin")
      expect(request.env["warden"].user(:admin)).to eq(admin)
    end

    it "keeps the login page and reports invalid credentials" do
      post admin_session_path, params: {
        admin: { email: "nobody@example.com", password: "wrong-password" }
      }

      expect(response).to have_http_status(:unprocessable_content)
      expect(inertia).to render_component("admins/sessions/new")
      expect(inertia).to have_props(email: "nobody@example.com")
      expect(inertia).to have_flash(
        alert: "Invalid Email or password."
      )
    end
  end
end
