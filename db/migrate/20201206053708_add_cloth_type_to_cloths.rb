class AddClothTypeToCloths < ActiveRecord::Migration[6.0]
  def change
    add_reference :cloths, :cloth_brand, foreign_key: true
  end
end
