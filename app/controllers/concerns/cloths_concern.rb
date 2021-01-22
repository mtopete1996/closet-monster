module ClothsConcern
  extend ActiveSupport::Concern
  include ApplicationHelper

  included do
    before_action :user_logged
  end

  def index
    @cloths = cloths
    @total_pages = cloths.total_pages
    @parameters = cloths_params
    render 'admin/cloths/index'
  end

  def new
    @cloth_data = cloth_data
    render 'admin/cloths/new'
  end

  def create
    @cloth_data = cloth_data(cloth_params)
    another_path = success_link if params[:other]
    return save_successful(action: :saved, path: another_path) if cloth_data.cloth.save

    render 'admin/cloths/new'
  end

  def edit
    @cloth_data = cloth_data(id: params[:id])
    render 'admin/cloths/edit'
  end

  def update
    @cloth_data = cloth_data(id: params[:id])
    return save_successful(action: :updated) if cloth_data.cloth.update(cloth_params)

    render 'admin/cloths/edit'
  end

  def destroy
    @cloth_data = cloth_data(id: params[:id])
    return save_successful(action: :deleted) if cloth_data.cloth.destroy

    flash[:error] = 'There has been a problem deleting this record, please contact support'
    render 'admin/cloths/index'
  end

  private

  attr_reader :cloth

  def cloth_data(data = {})
    @cloth_data ||= ClothData.new(data.merge(user: current_user))
  end

  def cloth_params
    params.required(:cloth).permit(:name, :last_time_worn, :picture, :cloth_type_id, :cloth_brand_id)
  end

  def cloths
    @cloths ||= current_user.cloths.page(page).per(per).order_by(cloths_params[:order_by]).with_data
                            .with_attached_picture
  end

  def cloths_params
    params.permit(:order_by, :page, :per)
  end

  def index_path
    link_for(page: 'cloths', mod: module_name)
  end

  def module_name
    @module_name ||= self.class.module_parent.name.downcase
  end

  def page
    @page ||= params[:page] || 1
  end

  def per
    @per ||= params[:per] || 12
  end

  def save_successful(action:, path: nil)
    path ||= link_for(page: 'cloths', mod: module_name)
    flash[:success] = "Cloth has been #{action} successfully"
    redirect_to path
  end

  def success_link
    link_for(prefix: 'new', page: 'cloth', mod: module_name)
  end
end
