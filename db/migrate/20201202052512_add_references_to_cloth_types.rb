class AddReferencesToClothTypes < ActiveRecord::Migration[6.0]
  def change
    add_reference :cloth_types, :user, foreign_key: true
    add_reference :cloths, :cloth_type, foreign_key: true
  end
end
