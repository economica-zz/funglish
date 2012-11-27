class CreateChapters < ActiveRecord::Migration
  def change
    create_table :chapters do |t|
      t.references :lesson
      t.integer :number
      t.string :name
      t.integer :price
      t.string :cloudinary_public_id
      t.string :description
      t.boolean :is_released
      t.date :scheduled_release_date
      t.string :panda_video_id
      t.boolean :deleted, null: false, default: false
      t.timestamps
    end

    add_index :chapters, [:lesson_id, :deleted], name: "idx_chapters_01"
  end
end
