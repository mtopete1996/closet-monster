module ApplicationHelper
  ACTIONS = %w[index new create show edit update destroy].freeze
  MODULES = %w[admin monster].freeze

  # action_index?
  # action_new?
  # action_create?
  # action_show?
  # action_edit?
  # action_update?
  # action_destroy?
  ACTIONS.each do |act|
    define_method("action_#{act}?") { action_name == act }
  end

  MODULES.each do |mod|
    define_method("module_#{mod}?") { module_name == mod }
  end

  def fallback_script
    fallback_url = asset_path('admin/cloths/default.jpg')
    %(this.onerror = null; this.src="#{fallback_url}")
  end

  def format_datetime(timestamp, format: :dmy)
    timestamp.strftime(t("utils.date.#{format}"))
  end

  def module_name
    @module_name ||= begin
      name = controller.class.module_parent.name.downcase.to_sym
      name if name != 'object'
    end
  end

  def page_buttons(route, parameters, total, current)
    current ||= 1
    (1..total).map do |pag|
      complete_route = *route
      parameters[:page] = pag
      complete_route << parameters.to_h
      active = pag == current.to_i ? :active : nil
      link_to pag, complete_route, class: "btn btn-secondary #{active}"
    end
  end
end
