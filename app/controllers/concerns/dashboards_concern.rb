module DashboardsConcern
  extend ActiveSupport::Concern

  def show
    render 'admin/dashboards/show'
  end
end
