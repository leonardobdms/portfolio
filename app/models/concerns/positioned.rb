# frozen_string_literal: true

module Positioned
  extend ActiveSupport::Concern

  included do
    before_validation :assign_position, on: :create
    scope :ordered, -> { order(:position, :id) }
  end

  private

  def assign_position
    return if position.present?

    self.position = (self.class.maximum(:position) || -1) + 1
  end
end
