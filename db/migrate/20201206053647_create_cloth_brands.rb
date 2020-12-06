class CreateClothBrands < ActiveRecord::Migration[6.0]
  def change
    create_table :cloth_brands do |t|
      t.string :name
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
