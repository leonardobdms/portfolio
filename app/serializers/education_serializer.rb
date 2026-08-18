# frozen_string_literal: true

class EducationSerializer < ApplicationSerializer
  attributes :id,
             :profile_id,
             :institution,
             :course,
             :degree,
             :description,
             :start_date,
             :end_date,
             :current,
             :position,
             :created_at,
             :updated_at
end
