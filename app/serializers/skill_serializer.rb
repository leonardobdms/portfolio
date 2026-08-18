# frozen_string_literal: true

class SkillSerializer < ApplicationSerializer
  attributes :id,
             :profile_id,
             :name,
             :slug,
             :category,
             :icon,
             :description,
             :level,
             :position,
             :created_at,
             :updated_at
end
