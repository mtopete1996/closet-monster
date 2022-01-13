module ClothTypesConcern
  extend ActiveSupport::Concern
  include ApplicationHelper
  include PaginationSupport
  include SuccessfulActionSupport

  def index
    @cloth_types = cloth_types
    @total_pages = cloth_types&.total_pages
    @parameters = types_parameters
    render 'admin/cloth_types/index'
  end

  def new
    @cloth_type = ClothType.new
    render 'admin/cloth_types/new'
  end

  def create
    @cloth_type = ClothType.new(permited_params)
    return save_successful(:cloth_types) if cloth_type.save

    render 'admin/cloth_types/new'
  end

  def edit
    @cloth_type = find_cloth_type
    render 'admin/cloth_types/edit'
  end

  def update
    @cloth_type = find_cloth_type
    return save_successful(:cloth_types, action: :updated) if cloth_type.update(permited_params)

    render 'admin/cloth_types/edit'
  end

  def destroy
    return save_successful(:cloth_types, action: :deleted) if find_cloth_type.destroy

    flash[:error] = 'There has been a problem deleting this record, please contact support'
    render 'admin/cloth_types/index'
  end

  private

  attr_reader :cloth_type

  def cloth_types
    @cloth_types ||= current_user.cloth_types.by_name.page(page).per(per)
  end

  def find_cloth_type
    @find_cloth_type ||= ClothType.find_by(id: params[:id])
  end

  def permited_params
    params.required(:cloth_type).permit(:name).merge(user: current_user)
  end

  def types_parameters
    params.permit(:page, :per)
  end
end
