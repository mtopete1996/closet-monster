module Admin
  class ClothTypesController < AdminController
    include ClothTypesConcern

    def cloth_types
      @cloth_types ||= ClothType.by_name.page(page).per(per)
    end
  end
end
