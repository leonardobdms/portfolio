# frozen_string_literal: true

class Avo::ProfilesController < Avo::ResourcesController
  def index
    profile = Profile.order(:id).first

    if profile
      redirect_to avo.resources_profile_path(id: profile.to_param)
    else
      redirect_to avo.new_resources_profile_path
    end
  end

  def new
    profile = Profile.order(:id).first

    if profile
      redirect_to avo.resources_profile_path(id: profile.to_param)
    else
      super
    end
  end
end
