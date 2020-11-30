module ClothsConcern
  extend ActiveSupport::Concern

  included do
    before_action :user_logged
  end

  def index
    @cloths = current_user_cloths
    render 'admin/cloths/index', layout: 'application'
  end

  def new
    @cloth = Cloth.new
    render 'admin/cloths/new', layout: 'application'
  end

  def create
    @cloth = Cloth.new(permited_params)
    return save_successful(action: :saved) if cloth.save

    render 'admin/cloths/new', layout: 'application'
  end

  def edit
    @cloth = find_cloth
    render 'admin/cloths/edit', layout: 'application'
  end

  def update
    @cloth = find_cloth
    return save_successful(action: :updated) if cloth.update(permited_params)

    render 'admin/cloths/edit', layout: 'application'
  end

  def destroy
    return save_successful(action: :deleted) if find_resource.destroy

    flash[:error] = 'There has been a problem deleting this record, please contact support'
    render 'admin/cloths/index', layout: 'application'
  end

  private

  attr_reader :cloth

  delegate :cloths, :role, to: :current_user, prefix: true

  def find_cloth
    @find_cloth ||= Cloth.find_by(id: params[:id])
  end

  def permited_params
    params.required(:cloth).permit(:name, :last_time_worn, :picture).merge(user: current_user)
  end

  def save_successful(action:)
    flash[:success] = "Cloth has been #{action} successfully"
    redirect_to index_path, layout: 'application'
  end

  def index_path
    byebug
    Rails.application.routes.url_helpers.send("#{module_name}_cloths_path")
  end

  def module_name
    self.class.module_parent.name.downcase
  end
end
