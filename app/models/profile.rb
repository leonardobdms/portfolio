# frozen_string_literal: true

class Profile < ApplicationRecord
  has_many :experiences, -> { order(:position, :id) }, dependent: :destroy, inverse_of: :profile
  has_many :educations, -> { order(:position, :id) }, dependent: :destroy, inverse_of: :profile
  has_many :skills, -> { order(:position, :id) }, dependent: :destroy, inverse_of: :profile
  has_many :projects, -> { order(:position, :id) }, dependent: :destroy, inverse_of: :profile
  has_many :certifications, -> { order(:position, :id) }, dependent: :destroy, inverse_of: :profile
  has_many :social_links, -> { order(:position, :id) }, dependent: :destroy, inverse_of: :profile

  validates :name, presence: true

  def self.current
    first
  end
end
