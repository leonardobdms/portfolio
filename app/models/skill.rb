# frozen_string_literal: true

class Skill < ApplicationRecord
  include Positioned

  enum :level, { featured: 0, core: 1, catalog: 2 }

  ALIASES = {
    "api rest" => "REST APIs",
    "apis" => "REST APIs",
    "rswag / swagger" => "Swagger",
    "banco de dados relacional" => "PostgreSQL"
  }.freeze

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :icon, :level, presence: true

  scope :listed, -> { where(level: %i[featured core]) }

  def self.icon_for(name)
    named_icons([ name ]).dig(0, :icon).to_s
  end

  def self.named_icons(names)
    map = catalog
    Array(names).map { |item| { name: item, icon: map[item.to_s.strip.downcase].to_s } }
  end

  def self.catalog
    map = pluck(:name, :icon).to_h { |skill_name, icon| [ skill_name.downcase, icon ] }
    ALIASES.each do |alias_name, canonical|
      map[alias_name] ||= map[canonical.downcase]
    end
    map
  end
end
