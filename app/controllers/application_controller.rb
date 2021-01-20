class ApplicationController < ActionController::Base
  # index, new, create, show, edit, update, destroy
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    return monster_root_path if resource.monster?

    admin_root_path
  end

  def authorized_user
    redirect_to monster_root_path unless current_user.admin?
  end

  def user_logged
    redirect_to root_path if current_user.blank?
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name username email password password_confirmation])
  end
end
