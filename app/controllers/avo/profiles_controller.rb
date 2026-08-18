# frozen_string_literal: true

class Avo::ProfilesController < Avo::ResourcesController
  def new
    redirect_to avo.resources_profiles_path, alert: t("profiles.already_exists")
  end

  def create
    redirect_to avo.resources_profiles_path, alert: t("profiles.already_exists")
  end

  def destroy
    redirect_to avo.resources_profiles_path, alert: t("profiles.cannot_destroy")
  end
end
