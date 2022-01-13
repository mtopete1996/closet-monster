module Admin
  class ClothBrandsController < AdminController
    include ClothBrandsConcern

    def cloth_brands
      @cloth_brands ||= ClothBrand.by_name.page(page).per(per)
    end
  end
end
