# frozen_string_literal: true

class SocialLinkSerializer < ApplicationSerializer
  attributes :id,
             :profile_id,
             :platform,
             :url,
             :username,
             :icon,
             :position,
             :created_at,
             :updated_at
end
