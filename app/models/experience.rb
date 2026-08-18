# frozen_string_literal: true

class Experience < ApplicationRecord
  include Positioned

  validates :role, :period, :description, presence: true

  def technologies_list
    Array(technologies).map(&:strip).compact_blank
  end
end
