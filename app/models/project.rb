# frozen_string_literal: true

class Project < ApplicationRecord
  belongs_to :profile
  has_many :project_skills, dependent: :destroy
  has_many :skills, through: :project_skills

  validates :name, :slug, presence: true
  validates :slug, uniqueness: true
end
