class CreateLessonMaterials < ActiveRecord::Migration
  def change
    create_table :lesson_materials do |t|
      t.references :lesson
      t.references :material
      t.string :file_name
      t.boolean :deleted, null: false, default: false
      t.timestamps
    end

    add_index :lesson_materials, [:lesson_id, :deleted], name: "idx_lesson_materials_01"
  end
end
