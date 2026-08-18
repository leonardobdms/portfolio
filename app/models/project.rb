# frozen_string_literal: true

class Project < ApplicationRecord
  include Positioned

  ICONS = %w[landmark hammer store building-2 truck newspaper shield-check puzzle gem].freeze

  before_validation :assign_slug, on: :create

  validates :name, :slug, :summary, :description, :icon, presence: true
  validates :slug, uniqueness: true, format: { with: /\A[a-z0-9]+(?:-[a-z0-9]+)*\z/ }
  validates :icon, inclusion: { in: ICONS }

  def technologies_list
    Array(technologies).map(&:strip).compact_blank
  end

  def highlights_list
    Array(highlights).map(&:strip).compact_blank
  end

  def description_paragraphs
    description.to_s.split(/\n{2,}/).map(&:strip).compact_blank
  end

  private

  def assign_slug
    return if slug.present?

    self.slug = name.to_s.parameterize
  end
end
