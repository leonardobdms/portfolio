# frozen_string_literal: true

class ProjectsController < InertiaController
  def show
    @profile = Profile.current
    @project = @profile.projects.find_by!(slug: params[:slug])
    previous_project = @profile.projects
      .where("position < ?", @project.position)
      .reorder(position: :desc)
      .first
    next_project = @profile.projects
      .where("position > ?", @project.position)
      .reorder(:position)
      .first

    render inertia: "projects/show", props: {
      profile: ProfileSerializer.new(@profile).serializable_hash,
      project: ProjectSerializer.new(@project).serializable_hash,
      previous_slug: previous_project&.slug,
      next_slug: next_project&.slug
    }
  end
end
