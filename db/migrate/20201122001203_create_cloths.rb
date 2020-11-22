class CreateCloths < ActiveRecord::Migration[6.0]
  def change
    create_table :cloths do |t|
      t.string :name, null: false
      t.boolean :enabled, null: false, default: true
      t.date :last_time_worn

      t.timestamps
    end
  end
end
