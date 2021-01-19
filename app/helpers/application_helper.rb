module ApplicationHelper
  ACTIONS = %w[index new create show edit update destroy].freeze

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

  def format_datetime(timestamp, format: :dmy)
    timestamp.strftime(t("utils.date.#{format}"))
  end

  def link_for(prefix: '', page:, params: {}, mod: nil)
    routes = Rails.application.routes.url_helpers
    return routes.root_path if current_user.blank? && module_name.blank? && mod.blank?

    routes.send(build_path(prefix, mod, page), **params)
  end

  def module_name
    name = controller.class.module_parent.name.downcase
    return name if name != 'object'
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

  private

  def build_path(prefix, mod, page)
    mod ||= module_name
    route_name = page + '_path'
    route_name.prepend(mod, '_') if mod.present?
    route_name.prepend(prefix, '_') if prefix.present?
    route_name
  end
end
