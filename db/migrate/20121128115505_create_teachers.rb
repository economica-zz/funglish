class CreateTeachers < ActiveRecord::Migration
  def change
    create_table :teachers do |t|
      t.references :course
      t.string :name
      t.string :cloudinary_public_id
      t.text :description
      t.boolean :deleted, null: false, default: false
      t.timestamps
    end

    add_index :teachers, [:course_id, :deleted], name: "idx_teachers_01"
  end
end
