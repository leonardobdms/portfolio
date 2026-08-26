# frozen_string_literal: true

module SetTheme
  extend ActiveSupport::Concern

  included do
    before_action :set_theme
    helper_method :theme_class if respond_to?(:helper_method)
  end

  private

  def set_theme
    @theme = ThemeResolver.call(cookies: cookies)
  end

  def theme_class
    ThemeResolver.html_class(@theme)
  end
end
