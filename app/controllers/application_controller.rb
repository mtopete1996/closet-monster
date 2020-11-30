class ApplicationController < ActionController::Base
  # index, new, create, show, edit, update, destroy

  def after_sign_in_path_for(resource)
    return monster_dashboard if resource.monster?

    admin_dashboard_path
  end

  def user_logged
    redirect_to root_path if current_user.blank?
  end
end
