# frozen_string_literal: true

class Avo::Resources::Skill < Avo::BaseResource
  self.title = :name
  self.icon = "tabler/outline/stack-2"
  self.description = -> { I18n.t("avo.resources.skill.description") }
  self.default_sort_column = :position
  self.default_sort_direction = :asc
  self.index_query = -> { query.ordered }
  self.search = {
    query: -> { query.where("name ILIKE ?", "%#{ActiveRecord::Base.sanitize_sql_like(q)}%") }
  }

  def fields
    field :id, as: :id, hide_on: :index
    field :name, as: :text, required: true, sortable: true, link_to_record: true
    field :icon, as: :text, required: true, help: I18n.t("avo.resources.skill.help.icon")
    field :level, as: :select, hide_on: :index,
      options: {
        I18n.t("activerecord.enums.skill.level.featured") => "featured",
        I18n.t("activerecord.enums.skill.level.core") => "core",
        I18n.t("activerecord.enums.skill.level.catalog") => "catalog"
      },
      help: I18n.t("avo.resources.skill.help.level")
    field :level, as: :badge, only_on: :index,
      options: { info: :featured, neutral: :core, warning: :catalog }
    field :position, as: :number, sortable: true, help: I18n.t("avo.resources.skill.help.position")
  end
end
