module Monster
  class MonsterController < ApplicationController
    before_action :user_logged
  end
end
