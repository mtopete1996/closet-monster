module Admin
  class AdminController < ApplicationController
    before_action :user_logged
    before_action :redirect_to_monster

    def redirect_to_monster
      return redirect_to monster_root_path if current_user&.monster?
      return redirect_to root_path if current_user.blank?
    end
  end
end
