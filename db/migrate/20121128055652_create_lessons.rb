class CreateLessons < ActiveRecord::Migration
  def change
    create_table :lessons do |t|
      t.references :course
      t.integer :number
      t.string :name
      t.integer :price
      t.string :cloudinary_public_id
      t.text :description
      t.boolean :is_released
      t.date :scheduled_release_date
      t.date :release_date
      t.string :panda_video_id
      t.boolean :is_main_lesson, null: false, default: false
      t.references :main_lesson
      t.boolean :deleted, null: false, default: false
      t.timestamps
    end

    add_index :lessons, [:course_id, :is_main_lesson, :deleted], name: "idx_lessons_01"
    add_index :lessons, [:main_lesson_id, :is_main_lesson, :deleted], name: "idx_lessons_02"
end
end
