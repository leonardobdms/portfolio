# frozen_string_literal: true

class Avo::SidebarComponent < Avo::BaseComponent
  include Avo::Concerns::PrivateAccess

  prop :sidebar_open, default: false
  prop :for_mobile, default: false

  def dashboards
    return [] unless Avo.plugin_manager.installed?("avo-dashboards")

    Avo::Dashboards.dashboard_manager.dashboards_for_navigation
  end

  def tools
    Avo.tool_manager.tools_for_navigation
  end

  def pages
    return [] unless Avo.plugin_manager.installed?("avo-forms")

    Avo::Forms::Core::Page.descendants.uniq(&:name).select(&:main_page?)
  end

  def stimulus_target
    @for_mobile ? "mobileSidebar" : "sidebar"
  end
end
