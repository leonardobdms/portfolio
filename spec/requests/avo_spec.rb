# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Avo admin panel", type: :request do
  describe "authentication" do
    it "redirects guests to the admin sign in page" do
      get "/admin"

      expect(response).to redirect_to("/admins/sign_in")
    end

    it "allows an authenticated admin to access the panel" do
      sign_in create(:admin)

      get "/admin"

      expect(response).to have_http_status(:redirect).or have_http_status(:success)
    end
  end

  describe "appearance" do
    it "locks the official dark identity" do
      appearance = Avo.configuration.appearance

      expect(appearance.scheme).to eq(:dark)
      expect(appearance.accent).to eq(:brand)
      expect(appearance.neutral).to eq(:brand)
      expect(appearance.accent_colors[:color]).to eq("#6366F1")
      expect(appearance.accent_colors[:content]).to eq("#4F46E5")
      expect(appearance.accent_colors[:foreground]).to eq("#F8FAFC")
      expect(appearance.lock).to include(:scheme, :neutral, :accent)
    end

    it "loads design tokens so dark text can resolve" do
      sign_in create(:admin)
      profile = create(:profile)

      get "/admin/resources/profiles/#{profile.to_param}"

      expect(response).to have_http_status(:success)
      expect(response.body).to include("design_tokens")
    end
  end

  describe "profile as a singular resource" do
    it "opens the existing profile instead of the index" do
      sign_in create(:admin)
      profile = create(:profile)

      get "/admin/resources/profiles"

      expect(response).to redirect_to("/admin/resources/profiles/#{profile.to_param}")
    end

    it "redirects new profile to the existing record" do
      sign_in create(:admin)
      profile = create(:profile)

      get "/admin/resources/profiles/new"

      expect(response).to redirect_to("/admin/resources/profiles/#{profile.to_param}")
    end

    it "redirects the index to new when no profile exists" do
      sign_in create(:admin)

      get "/admin/resources/profiles"

      expect(response).to redirect_to("/admin/resources/profiles/new")
    end

    it "renders the new profile form when none exists" do
      sign_in create(:admin)

      get "/admin/resources/profiles/new"

      expect(response).to have_http_status(:success)
    end
  end

  describe "resources" do
    it "loads the projects index" do
      sign_in create(:admin)
      create(:project)

      get "/admin/resources/projects"

      expect(response).to have_http_status(:success)
    end

    it "loads the skills index" do
      sign_in create(:admin)
      create(:skill)

      get "/admin/resources/skills"

      expect(response).to have_http_status(:success)
    end

    %w[
      experiences educations certifications social_links contacts project_skills
    ].each do |resource|
      it "loads the #{resource} index" do
        sign_in create(:admin)
        create(:profile)
        create(:contact) if resource == "contacts"
        create(:project_skill) if resource == "project_skills"
        create(:experience) if resource == "experiences"
        create(:education) if resource == "educations"
        create(:certification) if resource == "certifications"
        create(:social_link) if resource == "social_links"

        get "/admin/resources/#{resource}"

        expect(response).to have_http_status(:success)
      end
    end

    it "renders the sidebar in Portuguese when the locale cookie is set" do
      sign_in create(:admin)
      cookies[:locale] = "pt-BR"
      profile = create(:profile)

      get "/admin/resources/profiles/#{profile.to_param}"

      expect(response).to have_http_status(:success)
      expect(response.body).to include("Carreira")
      expect(response.body).to include("Habilidades")
      expect(response.body).to include("Mensagens")
      expect(response.body).to include("Contatos")
    end

    it "lists contacts in the sidebar and shows a message" do
      sign_in create(:admin)
      create(:profile)
      contact = create(:contact, subject: "Project inquiry", message: "I would like to discuss a project with you.")

      get "/admin/resources/contacts"

      expect(response).to have_http_status(:success)
      expect(response.body).to include(I18n.t("admin.sidebar.messages"))
      expect(response.body).to include(I18n.t("admin.sidebar.contacts"))
      expect(response.body).to include("/admin/resources/contacts")
      expect(response.body).to include(contact.subject)

      get "/admin/resources/contacts/#{contact.to_param}"

      expect(response).to have_http_status(:success)
      expect(response.body).to include(contact.name)
      expect(response.body).to include(contact.email)
      expect(response.body).to include(contact.message)
    end
  end
end
