# frozen_string_literal: true

class Avo::Resources::Experience < Avo::BaseResource
  self.title = :role
  self.icon = "tabler/outline/briefcase"
  self.description = -> { I18n.t("avo.resources.experience.description") }
  self.default_sort_column = :position
  self.default_sort_direction = :asc
  self.index_query = -> { query.ordered }
  self.search = {
    query: -> {
      query.where("role ILIKE :q OR company ILIKE :q OR period ILIKE :q", q: "%#{ActiveRecord::Base.sanitize_sql_like(q)}%")
    }
  }

  def fields
    field :id, as: :id, hide_on: :index
    field :role, as: :text, required: true, link_to_record: true
    field :company, as: :text, help: I18n.t("avo.resources.experience.help.company")
    field :url, as: :text, help: I18n.t("avo.resources.experience.help.url")
    field :period, as: :text, required: true
    field :description, as: :textarea, required: true, rows: 5, hide_on: :index
    field :technologies, as: :tags
    field :position, as: :number, sortable: true
  end
end
