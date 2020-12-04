module Admin
  class ClothTypesController < ApplicationController
    include ClothTypesConcern

    before_action :authorized_user
  end
end
