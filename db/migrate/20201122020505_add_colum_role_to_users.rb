class AddColumRoleToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :role, :string, default: :monster, null: false
  end
end
