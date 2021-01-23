class ApplicationController < ActionController::Base
  # index, new, create, show, edit, update, destroy
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    return monster_root_path if resource.monster?

    admin_root_path
  end

  def user_logged
    redirect_to root_path if no_user && admin_or_monster?
  end

  protected

  def admin_or_monster?
    %w[admin monster].include?(self.class.module_parent.name.downcase)
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name username email password password_confirmation])
  end

  def no_user
    @no_user ||= current_user.blank?
  end
end
