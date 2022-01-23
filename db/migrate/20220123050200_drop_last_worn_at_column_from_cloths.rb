class DropLastWornAtColumnFromCloths < ActiveRecord::Migration[6.0]
  def change
    remove_column :cloths, :last_time_worn
  end
end
