module Monster
  class ClothsController < CrudController
    def initialize
      @resource = Cloth
    end

    def permited_params
      params.required(:cloth).permit(:name, :last_time_worn, :picture).merge(user: User.first)
    end

    def success_path
      monster_cloths_path
    end
  end
end
