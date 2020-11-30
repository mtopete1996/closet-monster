module DashboardHelper
  def cloths_link
    method = "#{current_user.role}_cloths_path"
    Rails.application.routes.url_helpers.send method
  end
end
