# frozen_string_literal: true

Avo.configure do |config|
  config.root_path = "/admin"
  config.app_name = "Portfolio"
  config.click_row_to_view_record = true
  config.authorization_client = nil

  config.home_path = -> {
    profile = Profile.order(:id).first
    helpers = Avo::Engine.routes.url_helpers

    if profile
      helpers.resources_profile_path(id: profile.to_param)
    else
      helpers.resources_profiles_path
    end
  }

  config.current_user_method = :current_admin
  config.sign_out_path_name = :destroy_admin_session_path

  config.set_context do
    {
      admin: current_admin
    }
  end

  config.appearance = {
    logo: "logo.png",
    logomark: "logo.png",
    favicon: "favicon.png",
    favicon_dark: "favicon.png",
    scheme: :dark,
    neutral: :brand,
    accent: :brand,
    lock: [ :scheme, :neutral, :accent ],
    persistence: :cookie,
    chart_colors: %w[#6366F1 #8B5CF6 #06B6D4 #818CF8 #4F46E5 #22C55E #F59E0B],
    accent_colors: {
      color: "#6366F1",
      content: "#4F46E5",
      foreground: "#F8FAFC"
    },
    neutral_colors: {
      25 => "#F8FAFC",
      50 => "#F1F5F9",
      100 => "#E2E8F0",
      200 => "#CBD5E1",
      300 => "#94A3B8",
      400 => "#64748B",
      500 => "#334155",
      600 => "#1E293B",
      700 => "#172033",
      800 => "#111827",
      900 => "#0B1120",
      950 => "#070B14"
    }
  }
end

Rails.application.config.to_prepare do
  Avo::BaseApplicationController.prepend(AvoLocale)
end
