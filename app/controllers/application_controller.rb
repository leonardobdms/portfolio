class ApplicationController < ActionController::Base
  include SetLocale
  include SetTheme

  helper SeoHelper

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  inertia_share locale: -> { I18n.locale.to_s }
  inertia_share theme: -> { @theme }
  inertia_share turnstile_site_key: -> { ENV["TURNSTILE_SITE_KEY"].presence }
end
