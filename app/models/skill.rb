# frozen_string_literal: true

class Skill < ApplicationRecord
  ICON_FORMAT = /\A[a-z0-9]+(?:-[a-z0-9]+)*\z/

  belongs_to :profile
  has_many :project_skills, dependent: :destroy
  has_many :projects, through: :project_skills

  validates :name, :slug, :category, :icon, presence: true
  validates :slug, uniqueness: true
  validates :icon, format: { with: ICON_FORMAT, allow_blank: true }
end
