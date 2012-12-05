class CreateGuests < ActiveRecord::Migration
  def change
    create_table :guests do |t|
      t.references :schedule
      t.references :user
      t.references :guest_status
      t.boolean :deleted, null: false, default: false
      t.timestamps
    end

    add_index :guests, [:schedule_id, :user_id, :deleted, :guest_status_id], name: "idx_guests_01"
    add_index :guests, [:user_id, :schedule_id, :deleted, :guest_status_id], name: "idx_guests_02"
  end
end
