module Admin
  class ClothTypesController < AdminController
    include ClothTypesConcern

    def cloth_types
      @cloth_types ||= ClothType.alphabetically.page(page).per(per)
    end
  end
end
