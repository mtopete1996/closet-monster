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

    method = (mod || module_name) + '_' + page + '_path'
    method.prepend(prefix, '_') if prefix.present?

    routes.send(method, **params)
  end

  def module_name
    name = controller.class.module_parent.name.downcase
    return name if name != 'object'
  end
end
