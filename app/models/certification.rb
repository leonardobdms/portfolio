# frozen_string_literal: true

class Certification < ApplicationRecord
  belongs_to :profile

  validates :name, :issuer, presence: true
end
