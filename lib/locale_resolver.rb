# frozen_string_literal: true

class LocaleResolver
  AVAILABLE = %w[en pt-BR].freeze
  COOKIE = :locale

  def self.call(cookies:, accept_language: nil)
    cookie = cookies[COOKIE].presence
    return cookie if available?(cookie)

    from_header(accept_language) || I18n.default_locale.to_s
  end

  def self.available?(locale)
    AVAILABLE.include?(locale.to_s)
  end

  def self.from_header(header)
    return if header.blank?

    header.to_s.split(",").each do |part|
      code = part.split(";").first.to_s.strip.downcase
      return "pt-BR" if code.start_with?("pt")
      return "en" if code.start_with?("en")
    end

    nil
  end
end
