class CreateTimeZones < ActiveRecord::Migration
  def change
    create_table :time_zones do |t|
      t.string :name, null: false
      t.boolean :dst, null: false
      t.string :utc_offset, null: false
      t.integer :disp_seq, null: false
      t.boolean :deleted, null: false, default: false
      t.timestamps
    end
  end
end
