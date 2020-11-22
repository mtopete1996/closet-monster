module Monster
  class ClothsController < CrudController
    layout 'application'

    def initialize
      @resource = Cloth
    end

    # def index
    #   @cloths = Cloth.all
    # end
  end
end
