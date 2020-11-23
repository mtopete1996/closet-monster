module Monster
  class ClothsController < CrudController
    def initialize
      @resource = Cloth
    end
  end
end
