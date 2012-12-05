class CreateMaterials < ActiveRecord::Migration
  def change
    create_table :materials do |t|
      t.string :name
      t.string :icon_file_name
      t.text :description
      t.boolean :deleted, null: false, default: false
      t.timestamps
    end
  end
end
