module ClothLogsConcern
  include ApplicationHelper
  include PaginationSupport
  include SuccessfulActionSupport

  def index
    @cloth_logs = cloth_logs
    @total_pages = cloth_logs.total_pages
    render 'admin/cloth_logs/index'
  end

  private

  attr_reader :cloth_log

  def cloth_logs
    @cloth_logs ||= current_user.cloth_logs.page(page).per(per)
  end
end
