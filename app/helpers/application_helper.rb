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

  def module_name
    name = controller.class.module_parent.name.downcase
    return name if name != 'object'
  end
end
