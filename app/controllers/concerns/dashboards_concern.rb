module DashboardsConcern
  extend ActiveSupport::Concern

  included do
    before_action :user_logged
  end

  def show
    render 'admin/dashboards/show'
  end
end
