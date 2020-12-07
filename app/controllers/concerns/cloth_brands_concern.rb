module ClothBrandsConcern
  extend ActiveSupport::Concern
  include ApplicationHelper

  included do
    before_action :user_logged
  end

  def index
    @cloth_brands = current_user.cloth_brands
    render 'admin/cloth_brands/index'
  end

  def new
    @cloth_brand = ClothBrand.new
    render 'admin/cloth_brands/new'
  end

  def create
    @cloth_brand = ClothBrand.new(permited_params)
    return save_successful(action: :saved) if cloth_brand.save

    render 'admin/cloth_brands/new'
  end

  def edit
    @cloth_brand = find_cloth_brand
    render 'admin/cloth_brands/edit'
  end

  def update
    @cloth_brand = find_cloth_brand
    return save_successful(action: :updated) if cloth_brand.update(permited_params)

    render 'admin/cloth_brands/edit'
  end

  def destroy
    return save_successful(action: :deleted) if find_cloth_brand.destroy

    flash[:error] = 'There has been a problem deleting this record, please contact support'
    render 'admin/cloth_brands/index'
  end

  private

  attr_reader :cloth_brand

  def find_cloth_brand
    @find_cloth_brand ||= ClothBrand.find_by(id: params[:id])
  end

  def permited_params
    params.required(:cloth_brand).permit(:name).merge(user: current_user)
  end

  def save_successful(action:)
    flash[:success] = "Cloth brand has been #{action} successfully"
    redirect_to index_path
  end

  def index_path
    link_for(page: 'cloth_brands', mod: self.class.module_parent.name.downcase)
  end
end
