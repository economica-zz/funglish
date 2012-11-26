class CreateOccupations < ActiveRecord::Migration
  def change
    create_table :occupations do |t|
      t.string :name
      t.integer :disp_seq
      t.boolean :deleted, null: false, default: false
      t.timestamps
    end
  end
end
