# frozen_string_literal: true

class ProjectSerializer < ApplicationSerializer
  attributes :id,
             :profile_id,
             :name,
             :slug,
             :short_description,
             :description,
             :image_url,
             :github_url,
             :demo_url,
             :featured,
             :position,
             :start_date,
             :end_date,
             :created_at,
             :updated_at

  many :skills, resource: SkillSerializer
end
