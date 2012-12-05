class CreateViews < ActiveRecord::Migration
  def change
    create_table :views do |t|
      t.references :user
      t.references :lesson
      t.references :auth_status
      t.boolean :deleted, null: false, default: false
      t.timestamps
    end

    add_index :views, [:user_id, :lesson_id, :auth_status_id], name: "idx_views_01"
    add_index :views, [:lesson_id, :user_id, :auth_status_id], name: "idx_views_02"
  end
end
