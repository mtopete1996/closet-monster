module ClothLogsConcern
  include ApplicationHelper
  include PaginationSupport
  include SuccessfulActionSupport

  def show
    @cloth_logs = cloth_logs
    render 'admin/calendar/show'
  end

  private

  attr_reader :cloth_log

  def cloth_logs
    @cloth_logs ||= current_user.cloth_logs.includes(:cloth)
  end
end
