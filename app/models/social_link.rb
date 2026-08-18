# frozen_string_literal: true

class SocialLink < ApplicationRecord
  belongs_to :profile

  validates :platform, :url, presence: true
end
