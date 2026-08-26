# frozen_string_literal: true

class ThemeResolver
  AVAILABLE = %w[dark light].freeze
  DEFAULT = "dark"
  COOKIE = :theme

  def self.call(cookies:)
    cookie = cookies[COOKIE].presence
    return cookie if available?(cookie)

    DEFAULT
  end

  def self.available?(theme)
    AVAILABLE.include?(theme.to_s)
  end

  def self.html_class(theme)
    available?(theme) ? theme.to_s : DEFAULT
  end
end
