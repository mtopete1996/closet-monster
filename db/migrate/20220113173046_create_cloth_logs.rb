class CreateClothLogs < ActiveRecord::Migration[6.0]
  def change
    create_table :cloth_logs do |t|
      t.timestamp :worn_at, null: false
      t.belongs_to :cloth, null: false, foreign_key: true

      t.timestamps
    end
  end
end
