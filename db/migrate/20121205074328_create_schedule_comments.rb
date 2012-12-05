class CreateScheduleComments < ActiveRecord::Migration
  def change
    create_table :schedule_comments do |t|
      t.references :schedule
      t.references :user
      t.text :content
      t.boolean :deleted, null: false, default: false
      t.timestamps
    end

    add_index :schedule_comments, [:schedule_id, :deleted], name: "idx_schedule_comments_01"
  end
end
