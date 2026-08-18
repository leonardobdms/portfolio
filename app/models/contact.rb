# frozen_string_literal: true

class Contact < ApplicationRecord
  include Positioned

  KINDS = %w[github linkedin email other].freeze

  validates :label, :kind, presence: true
  validates :kind, inclusion: { in: KINDS }

  scope :published, -> { where(published: true) }

  def href
    return if url.blank?

    kind == "email" && !url.start_with?("mailto:") ? "mailto:#{url}" : url
  end

  def external?
    kind != "email"
  end
end
