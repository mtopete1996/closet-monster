module Admin
  class DashboardsController < ApplicationController
    include DashboardsConcern

    before_action :authorized_user
  end
end
