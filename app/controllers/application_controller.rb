class ApplicationController < ActionController::Base
  # index, new, create, show, edit, update, destroy

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
end
