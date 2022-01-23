module ClothLogsConcern
  include ApplicationHelper
  include Support::Successable

  def create
    @cloth = ClothLog.create!(cloth_logs_params)
    save_successful(:log, action: :saved, path: [module_name, :cloths])
  end

  def show
    @cloth_logs = cloth_logs
    render 'admin/calendar/show'
  end

  private

  attr_reader :cloth, :cloth_log

  def cloth_logs
    @cloth_logs ||= current_user.cloth_logs.includes(:cloth)
  end

  def cloth_logs_params
    params.permit(:cloth_id, :worn_at)
  end
end
