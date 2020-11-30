module DashboardsConcern
  extend ActiveSupport::Concern

  included do
    before_action :user_logged
  end

  def show
    render 'admin/dashboard/show'
  end
end
