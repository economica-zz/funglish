class CreateLessons < ActiveRecord::Migration
  def change
    create_table :lessons do |t|
      t.string :name
      t.text :description
      t.string :image_file_name
      t.boolean :deleted, null: false, default: false
      t.timestamps
    end
  end
end
