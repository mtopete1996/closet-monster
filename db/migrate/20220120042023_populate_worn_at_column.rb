class PopulateWornAtColumn < ActiveRecord::Migration[6.0]
  def up
    log_data = Cloth.where.not(last_time_worn: nil).pluck(:id, :last_time_worn)
    log_data.each do |cloth|
      cloth_id, tstamp = cloth
      ClothLog.create!(cloth_id: cloth_id, worn_at: tstamp)
    end
  end
end
