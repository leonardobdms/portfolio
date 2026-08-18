# frozen_string_literal: true

class Avo::Resources::Project < Avo::BaseResource
  self.title = :name
  self.icon = "tabler/outline/folders"
  self.description = -> { I18n.t("avo.resources.project.description") }
  self.default_sort_column = :position
  self.default_sort_direction = :asc
  self.index_query = -> { query.ordered }
  self.search = {
    query: -> {
      query.where(
        "name ILIKE :q OR slug ILIKE :q OR summary ILIKE :q OR role ILIKE :q",
        q: "%#{ActiveRecord::Base.sanitize_sql_like(q)}%"
      )
    }
  }

  def fields
    field :id, as: :id, hide_on: :index
    field :name, as: :text, required: true, link_to_record: true
    field :slug, as: :text, hide_on: :index, help: I18n.t("avo.resources.project.help.slug")
    field :summary, as: :text, required: true
    field :description, as: :textarea, required: true, rows: 10, hide_on: :index,
          help: I18n.t("avo.resources.project.help.description")
    field :role, as: :text, help: I18n.t("avo.resources.project.help.role")
    field :icon, as: :select, required: true, options: {
      I18n.t("avo.resources.project.icons.landmark") => "landmark",
      I18n.t("avo.resources.project.icons.hammer") => "hammer",
      I18n.t("avo.resources.project.icons.store") => "store",
      I18n.t("avo.resources.project.icons.building_2") => "building-2",
      I18n.t("avo.resources.project.icons.truck") => "truck",
      I18n.t("avo.resources.project.icons.newspaper") => "newspaper",
      I18n.t("avo.resources.project.icons.shield_check") => "shield-check",
      I18n.t("avo.resources.project.icons.puzzle") => "puzzle",
      I18n.t("avo.resources.project.icons.gem") => "gem"
    }
    field :url, as: :text, help: I18n.t("avo.resources.project.help.url")
    field :github, as: :text, help: I18n.t("avo.resources.project.help.github")
    field :technologies, as: :tags
    field :highlights, as: :tags, hide_on: :index
    field :featured, as: :boolean, help: I18n.t("avo.resources.project.help.featured")
    field :position, as: :number, sortable: true
  end
end
