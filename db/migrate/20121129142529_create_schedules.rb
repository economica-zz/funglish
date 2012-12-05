class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.references :user
      t.timestamp :start_timestamp
      t.timestamp :end_timestamp
      t.integer :time
      t.references :lesson
      t.references :conversation_form
      t.references :location_prefecture
      t.string :location_name
      t.string :location_reference_url
      t.integer :maximum_number_of_guests
      t.text :message
      t.boolean :deleted, null: false, default: false
      t.timestamps
    end

    add_index :schedules, [:lesson_id, :start_timestamp, :deleted], name: "idx_schedules_01"
    add_index :schedules, [:user_id, :end_timestamp, :deleted], name: "idx_schedules_02"
  end
end
