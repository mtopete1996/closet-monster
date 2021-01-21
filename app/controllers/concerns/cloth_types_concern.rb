module ClothTypesConcern
  extend ActiveSupport::Concern
  include ApplicationHelper

  included do
    before_action :user_logged
  end

  def index
    @cloth_types = ClothType.user_types(current_user)
    render 'admin/cloth_types/index'
  end

  def new
    @cloth_type = ClothType.new
    render 'admin/cloth_types/new'
  end

  def create
    @cloth_type = ClothType.new(permited_params)
    return save_successful(action: :saved) if cloth_type.save

    render 'admin/cloth_types/new'
  end

  def edit
    @cloth_type = find_cloth_type
    render 'admin/cloth_types/edit'
  end

  def update
    @cloth_type = find_cloth_type
    return save_successful(action: :updated) if cloth_type.update(permited_params)

    render 'admin/cloth_types/edit'
  end

  def destroy
    return save_successful(action: :deleted) if find_cloth_type.destroy

    flash[:error] = 'There has been a problem deleting this record, please contact support'
    render 'admin/cloth_types/index'
  end

  private

  attr_reader :cloth_type

  def find_cloth_type
    @find_cloth_type ||= ClothType.find_by(id: params[:id])
  end

  def permited_params
    params.required(:cloth_type).permit(:name).merge(user: current_user)
  end

  def save_successful(action:)
    flash[:success] = "Cloth type has been #{action} successfully"
    redirect_to index_path
  end

  def index_path
    link_for(page: 'cloth_types', mod: self.class.module_parent.name.downcase)
  end
end
