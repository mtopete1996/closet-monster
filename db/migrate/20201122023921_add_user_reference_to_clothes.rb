class AddUserReferenceToClothes < ActiveRecord::Migration[6.0]
  def change
    add_reference :cloths, :user, foreign_key: true
  end
end
