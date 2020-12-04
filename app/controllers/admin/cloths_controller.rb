module Admin
  class ClothsController < ApplicationController
    include ClothsConcern

    before_action :authorized_user
  end
end
