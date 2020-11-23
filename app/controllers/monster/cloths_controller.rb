module Monster
  class ClothsController < CrudController
    layout 'application'

    def initialize
      @resource = Cloth
    end
  end
end
