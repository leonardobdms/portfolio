# frozen_string_literal: true

class ExperienceSerializer < ApplicationSerializer
  attributes :id,
             :profile_id,
             :company,
             :role,
             :employment_type,
             :location,
             :description,
             :start_date,
             :end_date,
             :current,
             :position,
             :created_at,
             :updated_at
end
