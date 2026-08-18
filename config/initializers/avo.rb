# frozen_string_literal: true

Avo.configure do |config|
  config.root_path = "/admin"
  config.app_name = "Leonardo"
  config.click_row_to_view_record = true
  config.authorization_client = nil
  config.locale = :"pt-BR"
  config.timezone = "America/Sao_Paulo"
  config.home_path = "/admin/resources/skills"

  config.current_user_method = :current_admin
  config.sign_out_path_name = :destroy_admin_session_path
  config.authenticate_with do
    authenticate_admin!
  end

  config.appearance = {
    scheme: :dark,
    neutral: :brand,
    accent: :brand,
    lock: [ :scheme, :neutral, :accent ],
    picker_layout: :dropdown,
    chart_colors: [ "#8ea0ff", "#3557c8", "#ecece8", "#a5a7ae", "#2c2d33" ],
    neutral_colors: {
      25 => "#fbfbf8",
      50 => "#f3f2ee",
      100 => "#ecece8",
      200 => "#e1e0db",
      300 => "#a5a7ae",
      400 => "#898b93",
      500 => "#5b5d64",
      600 => "#4a4c53",
      700 => "#2c2d33",
      800 => "#18191d",
      900 => "#141518",
      950 => "#111214"
    },
    accent_colors: {
      color: "#8ea0ff",
      content: "#3557c8",
      foreground: "#111214"
    }
  }
end
