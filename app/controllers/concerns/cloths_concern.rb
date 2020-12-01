module ClothsConcern
  extend ActiveSupport::Concern
  include ApplicationHelper

  included do
    before_action :user_logged
  end

  def index
    @cloths = current_user.cloths.with_attached_picture
    render 'admin/cloths/index'
  end

  def new
    @cloth = Cloth.new
    render 'admin/cloths/new'
  end

  def create
    @cloth = Cloth.new(permited_params)
    return save_successful(action: :saved) if cloth.save

    render 'admin/cloths/new'
  end

  def edit
    @cloth = find_cloth
    render 'admin/cloths/edit'
  end

  def update
    @cloth = find_cloth
    return save_successful(action: :updated) if cloth.update(permited_params)

    render 'admin/cloths/edit'
  end

  def destroy
    return save_successful(action: :deleted) if find_cloth.destroy

    flash[:error] = 'There has been a problem deleting this record, please contact support'
    render 'admin/cloths/index'
  end

  private

  attr_reader :cloth

  def find_cloth
    @find_cloth ||= Cloth.find_by(id: params[:id])
  end

  def permited_params
    params.required(:cloth).permit(:name, :last_time_worn, :picture).merge(user: current_user)
  end

  def save_successful(action:)
    flash[:success] = "Cloth has been #{action} successfully"
    redirect_to index_path
  end

  def index_path
    link_for(page: 'cloths', mod: self.class.module_parent.name.downcase)
  end
end
