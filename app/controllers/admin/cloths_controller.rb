module Admin
  class ClothsController < AdminController
    include ClothsConcern

    def cloths
      @cloths ||= Cloth.page(page).per(per).order_by(cloths_params[:order_by]).with_data.with_user
                              .with_attached_picture
    end
  end
end
