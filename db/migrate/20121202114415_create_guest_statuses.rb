class CreateGuestStatuses < ActiveRecord::Migration
  def change
    create_table :guest_statuses do |t|
      t.string :name
      t.boolean :deleted, null: false, default: false
      t.timestamps
    end
  end
end
