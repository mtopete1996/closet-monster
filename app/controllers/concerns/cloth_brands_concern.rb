module ClothBrandsConcern
  extend ActiveSupport::Concern
  include ApplicationHelper
  include SuccessfulActionSupport

  included do
    before_action :user_logged
  end

  def index
    @cloth_brands = current_user.cloth_brands.alphabetically
    render 'admin/cloth_brands/index'
  end

  def new
    @cloth_brand = ClothBrand.new
    render 'admin/cloth_brands/new'
  end

  def create
    @cloth_brand = ClothBrand.new(permited_params)
    respond_to do |format|
      format.html { html_resp }
      format.js { js_resp }
    end
  end

  def edit
    @cloth_brand = find_cloth_brand
    render 'admin/cloth_brands/edit'
  end

  def update
    @cloth_brand = find_cloth_brand
    return save_successful(:cloth_brands, action: :updated) if cloth_brand.update(permited_params)

    render 'admin/cloth_brands/edit'
  end

  def destroy
    return save_successful(:cloth_brands, action: :deleted) if find_cloth_brand.destroy

    flash[:error] = 'There has been a problem deleting this record, please contact support'
    render 'admin/cloth_brands/index'
  end

  private

  attr_reader :cloth_brand

  def find_cloth_brand
    @find_cloth_brand ||= ClothBrand.find_by(id: params[:id])
  end

  def html_resp
    return save_successful(:cloth_brands) if cloth_brand.save

    render 'admin/cloth_brands/new'
  end

  def js_resp
    flash[:success] = 'Cloth brand saved successfully'
    render 'admin/cloth_brands/new' if cloth_brand.save
  end

  def permited_params
    params.required(:cloth_brand).permit(:name).merge(user: current_user)
  end
end
