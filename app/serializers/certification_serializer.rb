# frozen_string_literal: true

class CertificationSerializer < ApplicationSerializer
  attributes :id,
             :profile_id,
             :name,
             :issuer,
             :description,
             :credential_url,
             :credential_id,
             :issued_at,
             :expires_at,
             :position,
             :created_at,
             :updated_at
end
