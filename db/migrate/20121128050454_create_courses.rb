class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :name
      t.text :description
      t.string :youtube_src
      t.string :cloudinary_public_id
      t.boolean :deleted, null: false, default: false
      t.timestamps
    end
  end
end
